class SessionsController < ApplicationController

	skip_before_action :authorized

	def create
		@user = User.find_by(username: params[:username])

		if @user && @user.authenticate(params[:password])
	  		session[:user_id] = @user.id
	  		if @user.position == "leader"
	  			redirect_to dashboards_path
	  		elsif @user.position == "admin"
	  			redirect_to admin_index_path
	  		else 
	  			redirect_to schedule_path
	  		end
		else
	  		message = "Oop Sorry ! Make sure your username and password are correct !!"
	  		redirect_to login_path , notice: message
		end
  	end

  	def destroy
		session.delete(:user_id)
		flash[:notice] = 'Logged out successfully.'
		redirect_to login_path
	end
end