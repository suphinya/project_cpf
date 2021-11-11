class DashboardsController < ApplicationController

	def index
	end

	def edit
		@department_name = params[:id]
	end

	def show
		@department_name = params[:id]
		@all_workers = User.where(:position => 'employee', :department1 => @department_name)
	end

end
