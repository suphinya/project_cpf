class DashboardsController < ApplicationController

	def index
	end

	def edit
		@dep = params[:id]
		@users = User.where(:department1 => @dep)
		@employee = @users.select{|user| user.position=="employee"}
		# click to assign shift
		if (params.key?('ass_button'))
			@calender = params[:emp][:date]
			# list of user id (tick checkbox)
			@uID_list = params[:select_user]
			new_time_out = (@calender+' '+(params[:time].split[2])).to_time
			new_time_in = (@calender+' '+(params[:time].split[0])).to_time
			tomorrow = ["00:00","00:30","01:00","01:30","02:00","02:30","03:00","03:30","04:00","04:30","05:00","05:30","06:00","06:30","07:00","07:30","08:00","08:30"]
			if tomorrow.include?(params[:time].split[2])
				new_time_out += (3600*24)
			end
			if @uID_list
				@uID_list.each do |uID|
					@all_user_plan = Plan.find_by_user_id(uID) # get database
					if @all_user_plan != nil
						# insert each data to Plan database
						if (@all_user_plan.time_in > new_time_out && @all_user_plan.time_in > new_time_in) || (@all_user_plan.time_out < new_time_in && @all_user_plan.time_out < new_time_out)
							@assign = Plan.create(time_plan)
							user = User.find(uID.to_i)
							user.plans << @assign
							if @assign.save
								#if creation is successful, show up 'successful' message
								flash[:notice] = "Assign shift successfully"
								#redirect_to edit_dashboard_path(@dep)
							else
								render 'edit'
							end
						# update each data to Plan database		
						elsif (@all_user_plan.time_in < new_time_out && @all_user_plan.time_in > new_time_in) || (@all_user_plan.time_out > new_time_in && @all_user_plan.time_out < new_time_out)
							if @all_user_plan.update_attributes(time_plan) 
						    	flash[:notice] = "Update shift successfully"
						    	#redirect_to edit_dashboard_path(@dep)
						    else
						    	render 'edit'
						    end
						else
							flash[:notice] = "Can't assign shift"
						end
					# create data Plan if don't have anything in database
					else
						@assign = Plan.create(time_plan)
						user = User.find(uID.to_i)
						user.plans << @assign
						if @assign.save
							#if creation is successful, show up 'successful' message
							flash[:notice] = "Assign shift successfully"
							#redirect_to edit_dashboard_path(@dep)
						else
							render 'edit'
						end
					end
				end
				redirect_to edit_dashboard_path(@dep)
			end
		end

		# time
		@all_time = ["00:00 - 09:00","00:30 - 09:30","01:00 - 10:00","01:30 - 10:30","02:00 - 11:00","02:30 - 11:30",
					"03:00 - 12:00","03:30 - 12:30","04:00 - 13:00","04:30 - 13:30","05:00 - 14:00","05:30 - 14:30",
					"06:00 - 15:00","06:30 - 15:30","07:00 - 16:00","07:30 - 16:30","08:00 - 17:00","08:30 - 17:30",
					"09:00 - 18:00","09:30 - 18:30","10:00 - 19:00","10:30 - 19:30","11:00 - 20:00","11:30 - 20:30",
					"12:00 - 21:00","12:30 - 21:30","13:00 - 22:00","13:30 - 22:30","14:00 - 23:00","14:30 - 23:30",
					"15:00 - 00:00","15:30 - 00:30","16:00 - 01:00","16:30 - 01:30","17:00 - 02:00","17:30 - 02:30",
					"18:00 - 03:00","18:30 - 03:30","19:00 - 04:00","19:30 - 04:30","20:00 - 05:00","20:30 - 05:30",
					"21:00 - 06:00","21:30 - 06:30","22:00 - 07:00","22:30 - 07:30","23:00 - 08:00","23:30 - 08:30"]

		@default_select = "00:00 - 09:00"

		@status = false
		
		if (params.key?("choose"))
			@calender = params[:emp][:date]
			@status = true
		end

	end

	def show
		@department_name = params[:id]
		@all_workers = User.where(:position => 'employee', :department1 => @department_name)
	
		@all_time = ["all","00:00 - 09:00","00:30 - 09:30","01:00 - 10:00","01:30 - 10:30","02:00 - 11:00","02:30 - 11:30",
					"03:00 - 12:00","03:30 - 12:30","04:00 - 13:00","04:30 - 13:30","05:00 - 14:00","05:30 - 14:30",
					"06:00 - 15:00","06:30 - 15:30","07:00 - 16:00","07:30 - 16:30","08:00 - 17:00","08:30 - 17:30",
					"09:00 - 18:00","09:30 - 18:30","10:00 - 19:00","10:30 - 19:30","11:00 - 20:00","11:30 - 20:30",
					"12:00 - 21:00","12:30 - 21:30","13:00 - 22:00","13:30 - 22:30","14:00 - 23:00","14:30 - 23:30",
					"15:00 - 00:00","15:30 - 00:30","16:00 - 01:00","16:30 - 01:30","17:00 - 02:00","17:30 - 02:30",
					"18:00 - 03:00","18:30 - 03:30","19:00 - 04:00","19:30 - 04:30","20:00 - 05:00","20:30 - 05:30",
					"21:00 - 06:00","21:30 - 06:30","22:00 - 07:00","22:30 - 07:30","23:00 - 08:00","23:30 - 08:30"]

		@select = "all" 

		@status = false

		if (params.key?("choose"))
			@select = params[:time_in]
			@calender = params[:date_work].values[0]
			@t_in = (@calender + ' '+ @select[0..4]).to_time
			@status = true
		end

	end

	def time_plan
		data = params.require(:emp).permit(:date, :OT)
		day = params[:emp][:date]
		str_time_in = params[:time].split[0]
		str_time_out = params[:time].split[2]
		data[:date] = day.to_time
		data[:time_in] = (day+' '+str_time_in).to_time
		check_time_out = (day+' '+str_time_out).to_time
		tomorrow = ["00:00","00:30","01:00","01:30","02:00","02:30","03:00","03:30","04:00","04:30","05:00","05:30","06:00","06:30","07:00","07:30","08:00","08:30"]
		if tomorrow.include? str_time_out
			data[:time_out] = check_time_out + (3600*24)
		else
			data[:time_out] = check_time_out
		end
		if params[:emp][:OT] == ""
			data[:OT] = 0
		end
		return data
	end

end
