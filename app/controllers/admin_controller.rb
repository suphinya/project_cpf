class AdminController < ApplicationController

	def index
		@leader_users = User.where(:position=>"leader")
		@worker_users = User.where(:position=>"employee")

	end

	def new
		if params.key?('submit')
			@username = params[:username].values[0]
			@password = params[:password].values[0]
			@name = params[:name].values[0]
			@surname = params[:surname].values[0]
			@position = params[:position]
			@department = params[:department1].values[0]
			if @position == "employee"
				user = User.create(:username=>@username, :password_digest=>@password, 
							:name=>@name, :surname=>@surname,
							:position=>@position, :department1=>@department)
			else
				user = User.create(:username=>@username, :password_digest=>@password, 
							:name=>@name, :surname=>@surname,
							:position=>@position, :department1=>[@department])
			end
			user.password = @password
			user.password_confirmation = @password
			user.save
			flash[:notice] = "create user complete"
			redirect_to admin_index_path
		end
	end

	def edit
		user_id = params[:id]
		@user = User.find(user_id)
	end

	def update
		user_id = params[:id]
		user = User.find(user_id)

		@username = params[:username].values[0]
		@password = params[:password].values[0]
		@name = params[:name].values[0]
		@surname = params[:surname].values[0]
		@position = params[:position]
		@department = params[:department1].values[0]

		if @position == "employee"
			user.update(:username=>@username, :password_digest=>@password, 
						:name=>@name, :surname=>@surname,
						:position=>@position, :department1=>@department)
		else
			user.update(:username=>@username, :password_digest=>@password, 
						:name=>@name, :surname=>@surname,
						:position=>@position, :department1=>[@department])
		end
		user.password = @password
		user.password_confirmation = @password
		user.save
		flash[:notice] = "Update Info complete"
		redirect_to admin_index_path
	end

	def destroy
		user_id = params[:id]
		user = User.find(user_id)
		user.destroy
		redirect_to admin_index_path
	end
	
end
