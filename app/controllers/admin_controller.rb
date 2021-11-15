class AdminController < ApplicationController

	def index
		@leader_users = User.where(:position=>"leader")
		@worker_users = User.where(:position=>"employee")
	end

	def create_employee
		if params.key?('submit')
			@username = params[:username].values[0]
			@password = params[:password].values[0]
			@name = params[:name].values[0]
			@surname = params[:surname].values[0]
			@position = "employee"
			@department = params[:department1].values[0]
			user = User.create(:username=>@username, :password_digest=>@password, 
						:name=>@name, :surname=>@surname,
						:position=>@position, :department1=>@department)
			user.password = @password
			user.password_confirmation = @password
			user.save
			flash[:notice] = "create employee"
			redirect_to admin_path
		end
	end

	def create_leader
		if params.key?('submit')
			@username = params[:username].values[0]
			@password = params[:password].values[0]
			@name = params[:name].values[0]
			@surname = params[:surname].values[0]
			@position = "leader"
			@department1 = params[:department1].values[0]
			@department2 = params[:department2].values[0]
			@department3 = params[:department3].values[0]
			user = User.create(:username=>@username, :password_digest=>@password, 
						:name=>@name, :surname=>@surname,
						:position=>@position, :department1=>@department1, 
						:department2=>@department2, :department3=>@department3)
			user.password = @password
			user.password_confirmation = @password
			user.save
			flash[:notice] = "create leader"
			redirect_to admin_path
		end
	end

end
