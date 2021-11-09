class DashboardsController < ApplicationController


	def index
	end

	def show
		@pa = params[:id]
	end

	def edit
		@pa = params[:id]
	end

end