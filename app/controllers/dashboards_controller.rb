class DashboardsController < ApplicationController

	def index
		@leader = current_user
		@all_depart = check_department(@leader.id)
	end

	def time_plan(date)
		data = params.require(:emp).permit(:date, :OT)
		#day = params[:emp][:date]
		str_time_in = params[:time].split[0]
		str_time_out = params[:time].split[2]
		data[:date] = date.to_time
		data[:time_in] = (date+' '+str_time_in).to_time
		check_time_out = (date+' '+str_time_out).to_time
		tomorrow = ["00:00","00:30","01:00","01:30","02:00","02:30","03:00","03:30","04:00","04:30","05:00","05:30","06:00","06:30","07:00","07:30","08:00","08:30"]
		if tomorrow.include? str_time_out
			data[:time_out] = check_time_out + (3600*24)
		else
			data[:time_out] = check_time_out
		end
		if params[:emp][:OT] == ""
			data[:OT] = 0
		else
			data[:OT] = (params[:emp][:OT].to_f).ceil(1)	
		end
		return data
	end

	def edit
		@today = Time.current.strftime("%Y-%m-%d")
		@dep = params[:id]
		@users = User.where(:department1 => @dep)
		@employee = @users.select{|user| user.position=="employee"}
		
		# click to assign shift
		if (params.key?('ass_button'))
			#@calender = params[:emp][:date]

			@date_in = params[:date_in].values[0]
			@date_out = params[:date_out].values[0]

			if @date_out.to_time >= @date_in.to_time
				# list of user id (tick checkbox)
				@uID_list = params[:select_user]

				time1 = @date_in.to_time
				time2 = @date_out.to_time

				dectime = (time2-time1) /(24*3600)
				

				for i in 0..dectime do 
					time_loop = ((@date_in.to_time) + (i*(24*3600)))
					@x = i
					date_loop = time_loop.strftime("%Y-%m-%d")
					new_time_out = (date_loop +' '+(params[:time].split[2])).to_time
					new_time_in = (date_loop +' '+(params[:time].split[0])).to_time
					tomorrow = ["00:00","00:30","01:00","01:30","02:00","02:30","03:00","03:30","04:00","04:30","05:00","05:30","06:00","06:30","07:00","07:30","08:00","08:30"]
					if tomorrow.include?(params[:time].split[2])
						new_time_out += (3600*24)
					end
					if @uID_list
						@uID_list.each do |uID|
							@all_user_plan = Plan.find_by(:user_id => uID , :date => date_loop) # get database
							@all_user_actual = Actual.find_by(:user_id => uID , :date => date_loop)
							if @all_user_plan != nil
								if @all_user_actual != nil && @all_user_actual.time_out != nil
									flash[:notice] = "Can't update shift"

								else
									if (@all_user_plan.time_in == new_time_in)&&(@all_user_plan.time_out == new_time_out )
										@all_user_plan.update(:OT => (params[:emp][:OT].to_f).ceil(1) )
										flash[:notice] = "Update OT success"
									else
										flash[:notice] = "Can't assign shift"
									end
								end
									
								
							else
								@assign = Plan.create(time_plan(date_loop))
								user = User.find(uID.to_i)
								user.plans << @assign
								if @assign.save
									#if creation is successful, show up 'successful' message
									flash[:notice] = "Assign new shift successfully"
									#redirect_to edit_dashboard_path(@dep)
								else
									render 'edit'
								end
							end
						end
						
					end
				end
				redirect_to edit_dashboard_path(@dep)

			else
				flash[:notice] = "Date should be sort"
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

		if (params.key?("delete"))
			list_userid = params[:select_user]
			date_plan = params[:emp][:date].to_time
			today = Time.current.strftime("%Y-%m-%d").to_time
			if list_userid != nil && date_plan >= today
				list_userid.each do |user|
					actual = Actual.find_by(:user_id => user , :date => date_plan)
					plan = Plan.find_by(:date => date_plan , :user_id => user)
					if plan != nil && actual == nil
						plan.destroy
					end
				end
			end

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

	def check_department(leader_id)
		user = User.find(leader_id)
		department = user.department1
		list_department = []
		department["["] = "" 
		department["]"] = ""
		n_string = department.split(",")

		n_string.each do |all|
			all.gsub!(" ","")
    		all.gsub!('"',"")
    		list_department.append(all)
    
    	end
		return list_department
	end

end
