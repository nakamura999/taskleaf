class ApplicationController < ActionController::Base
	helper_method :current_user
	# すべてのviewからcurrent_userが使える

	private

	def current_user
		@cuurent_user || = User.find_by(id: session[:user_id]) if session[:user_id]
		# session[:user_id]にユーザーのidが入り、current_userでUserオブジェクトを取得できる
	end

end
