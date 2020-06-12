class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: session_params[:email])
  	if user&.authenticate(session_params[:password])
  	   # authenticateメソッドでパスワードによる認証を行う　has_secure_passwordによる記述で自動的に追加されたメソッド
  		session[:user_id] = user.id
  		redirect_to root_path, notice: "ログインしました"
  	else
  		render :new
  	end
  end

  private

  def session_params
  	params.require(:session).permit(:email, :password)
  end

end
