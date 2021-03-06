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

		# เช็คอัพเดตแพลน
		@time_now = (Time.current+3600).strftime('%H:%M')

		@table_date = @today

		@status = false
		if (params.key?('choose'))
			@status = true
			@date_in = params[:date_in].values[0]
			@table_date = @date_in
		end
		# click to assign shift
		if (params.key?('ass_button'))

			@date_in = params[:date_in].values[0]
			@date_out = params[:date_out].values[0]
			
			@status = true
			@table_date = @date_in
			if @date_in.to_time >= @today.to_time
				if @date_out.to_time >= @date_in.to_time
					# list of user id (tick checkbox)
					@uID_list = params[:select_user]

					time1 = @date_in.to_time
					time2 = @date_out.to_time

					dectime = (time2-time1) /(24*3600)
					

					for i in 0..dectime do 
						time_loop = ((@date_in.to_time) + (i*(24*3600)))
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
									#กรณีเข้างาน-ออกงานแล้ว
									if @all_user_actual != nil && @all_user_actual.time_out != nil
										flash[:notice] = "Can't update shift"

									else
										# กรณีเข้างานแล้วแต่ยังไม่ได้ออกงานและเวลาแพลนเดิม สามารถอัพเดตโอทีได้
										if (@all_user_plan.time_in == new_time_in)&&(@all_user_plan.time_out == new_time_out )
											@all_user_plan.update(:OT => (params[:emp][:OT].to_f).ceil(1) )
											flash[:notice] = "Update OT success"
										else
											flash[:notice] = "Can't assign shift"
										end
									end

									# กรณีอัพเดตแพลนเมื่อเวลาปัจจุบันยังไม่ถึงแพลนที่จะกำหนดให้ (วันที่ปัจจุบัน)
									if (@all_user_actual == nil) && ( (new_time_in.strftime('%H:%M')).to_time >= @time_now.to_time )
										@all_user_plan.update(time_plan(date_loop))
										flash[:notice] = "Update Plan success"

									# กรณีอัพเดตแพลนเมื่อเวลาปัจจุบันยังไม่ถึงแพลนที่จะกำหนดให้ (ล่วงหน้า)
									elsif (@all_user_actual == nil) && ((new_time_in.strftime("%Y-%m-%d")).to_time > @today.to_time)
										@all_user_plan.update(time_plan(date_loop))
										flash[:notice] = "Update Plan success"
									end
										
									
								else
									#กรณีไม่มีแพลนสามารถสร้างแพลนได้
									if (new_time_in.strftime('%H:%M')).to_time >= @time_now.to_time
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
									elsif (new_time_in.strftime("%Y-%m-%d")).to_time > @today.to_time
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
									else
										flash[:notice] = "Please check date and time"
									end
								end
							end
							
						end
					
					end
				else
					flash[:notice] = "Date should be sort"
					redirect_to edit_dashboard_path(@dep)
				end
			else
				flash[:notice] = "You cannot assign plan in the pass!"
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

		

		if (params.key?("delete"))
			list_userid = params[:select_user]

			date_in = params[:date_in].values[0]
			date_out = params[:date_out].values[0]

			time1 = date_in.to_time
			time2 = date_out.to_time

			dectime = (time2-time1) /(24*3600)

			for i in 0..dectime do
				day_loop = ((date_in.to_time) + (i*(24*3600)))

				if list_userid != nil 
					list_userid.each do |user|
						actual = Actual.find_by(:user_id => user , :date => day_loop)
						plan = Plan.find_by(:date => day_loop , :user_id => user)
						if plan != nil && actual == nil
							plan.destroy
							flash[:notice] = "Delete plan success"
						else
							flash[:notice] = "Warning! Please check you plan & actual"
						end
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


	def dayoff
		@department = params[:id]
		@today = Time.current.strftime("%Y-%m-%d")
		@users = User.where(:department1 => @department)
		@employee = @users.select{|user| user.position=="employee"}

		if (params.key?("restday"))
			@user_id_list = params[:select_user]
			if @user_id_list
				@user_id_list.each do |uID|
					parameter = ("date_select_"+uID.to_s).to_sym
					@user_date_off = params[parameter].values[0]


					user_plan = Plan.find_by(:date => @user_date_off.to_time , :user_id => uID)
					user_actual = Actual.find_by(:date => @user_date_off.to_time , :user_id => uID)

					if user_actual == nil
						if user_plan != nil
							user_plan.destroy
							flash[:notice] = "Day off success"
						end
					else
						flash[:notice] = " Can't give day off for this day "
					end

				end
			end
		end
	end

end
