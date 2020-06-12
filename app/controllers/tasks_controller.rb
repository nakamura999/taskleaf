class TasksController < ApplicationController
  def index
  	@tasks = current_user.tasks.recent
    # @tasks = current_user.tasks.order(created_at: :desc)
    # recent モデルに記入
    # 作成日時新しい順
    # = Task.where(user_id: current_user.id)
  end

  def show
  	@task = current_user.tasks.find(params[:id])
  end

  def new
  	@task = Task.new
  end

  def edit
  	@task = current_user.tasks.find(params[:id])
  end

  def create
  	@task = Task.new(task_params.merge(user_id: current_user.id))
    # = current_user.tasks.new(task_params)
  	if @task.save
  	  redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
  end

  def update
  	task = current_user.tasks.find(params[:id])
    task.update!(task_params)
    redirect_to task_url, notice: "タスク「#{task.name}」を更新しました。"
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy
    redirect_to tasks_path, notice: "タスク「#{task.name}を削除しました」"
  end

  private

  def task_params
  	params.require(:task).permit(:name, :description)
  end
end
