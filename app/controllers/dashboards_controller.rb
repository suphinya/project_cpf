class DashboardsController < ApplicationController

	#before_action :require_login

	def require_login
		unless @current_user
			redirect_to login_path
		end
	end

	def index
	end
end