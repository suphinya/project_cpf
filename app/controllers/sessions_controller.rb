class SessionsController < ApplicationController

	def create
		@user = User.find_by(username: params[:username])

		if @user && @user.authenticate(params[:password])
	  		session[:user_id] = @user.id
	  		redirect_to root_path
		else
	  		message = "Oop Sorry ! Make sure your username and password are correct !!"
	  		redirect_to login_path , notice: message
		end
  	end

end