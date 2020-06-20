class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @q = current_user.tasks.ransack(params[:q])
  	@tasks = @q.result(distinct: true).page(params[:page]).per(10)
    # @tasks = current_user.tasks.recent
    # @tasks = current_user.tasks.order(created_at: :desc)
    # recentメソッド モデルに記入
    # 作成日時新しい順
    # = Task.where(user_id: current_user.id)
    respond_to do |format|
      format.html
      # Htmlとしてアクセスした場合。（特に指定無しーindex.html.slimによって画面が表示）
      format.csv { send_data @tasks.generate_csv, filename: "tasks-#{Time.zone.now.strftime('%Y%m%d%S')}.csv" }
      # send_dataメソッドを使って、レスポンスを送り出し、送り出したデータをブラウザからファイルをダウンロードできるようにする
      # ファイル名は、異なるファイル名になるように現在時刻を使って、作成
    end
  end

  def show
  end

  def new
  	@task = Task.new
  end

  def edit
  end

  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end

  def create
  	@task = current_user.tasks.new(task_params)

    if params[:back].present?
      render :new
      return
    end

  	if @task.save
  	  redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
  end

  def update
    @task.update!(task_params)
    redirect_to task_url, notice: "タスク「#{@task.name}」を更新しました。"
  end

  def destroy
    @task.destroy
    head :no_content
    # head レスポンスボディなしでHTTPステータスとして２０４（成功と判定される）が返る
    # redirect_to tasks_path, notice: "タスク「#{@task.name}を削除しました」"
  end

  private

  def task_params
  	params.require(:task).permit(:name, :description, :image)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
