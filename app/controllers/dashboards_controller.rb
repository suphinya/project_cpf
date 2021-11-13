class DashboardsController < ApplicationController


	def index
	end

	def show
		@dep = params[:id]
	end

	def time_plan
		# get input from view
		data = params.require(:emp).permit(:date, :time_in, :time_out, :OT)
		# edit date(time in/out) => date
		#[1,2,3].each do |n|
		#	data["time_in(#{n}i)"] = data["date(#{n}i)"]
		#	data["time_out(#{n}i)"] = data["date(#{n}i)"]
		#end
		return data
	end

	def edit
		@dep = params[:id]
		@users = User.where(:department1 => @dep)
		@employee = @users.select{|user| user.position=="employee"}
		# list of user id (tick checkbox)
		@uID_list = params[:select_user]

		if @uID_list
			# insert each data to Plan database
			@uID_list.each do |uID|
				@assign = Plan.create(time_plan)
				user = User.find(uID.to_i)
				user.plans << @assign
			end
			if @assign.save
				#if creation is successful, show up 'successful' message
				flash[:notice] = "successful"
				redirect_to edit_dashboard_path(@dep)
			else
				render 'edit'
			end
		end
	end
end
