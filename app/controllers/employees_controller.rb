class EmployeesController < ApplicationController

	def show
		@time = Time.current
		day = Time.current.strftime("%Y-%m-%d")
		@date = day.to_time 

		userid = current_user.id
		user = User.find(userid)
		plan = Plan.find_by(:user_id => userid , :date => @date)
		check_actual = Actual.find_by(:date => @date , :user_id => userid)

		######################## Show up plan's today #########################
		if plan == nil
			@plan_worker_today = false
		else
			@plan_worker_today = true
			@plan_today = plan
			if check_actual == nil
				@actual_worker_today = false
			else
				@actual_worker_today = true
				@actual_today = check_actual
			end
		end

		######################## Monthly's plan ##############################

		@all_plans = Plan.where(:user_id => userid) # .order("date DESC")
		@select_month = ['January', 'February', 'March', 'April', 'May', 'June', 
							'July', 'August', 'September', 'October', 'November', 'December']
		@select_month_default = @time.strftime("%B")
		@filter_month = false
		if (params.key?("month_choose"))
			@filter_month = true
			@select_month_default = params[:monthly]
			@first_day_month = '1 ' + @select_month_default + ' ' + @time.year.to_s
			last_day = Time.days_in_month(month=@select_month_default.to_time.month, year=@time.year)
			@last_day_month = last_day.to_s + ' ' + @select_month_default + ' ' + @time.year.to_s
		else
			@first_day_month = '1 ' + @select_month_default + ' ' + @time.year.to_s
			last_day = Time.days_in_month(month=@select_month_default.to_time.month, year=@time.year)
			@last_day_month = last_day.to_s + ' ' + @select_month_default + ' ' + @time.year.to_s
		end

		###################### Check in and Check out ###########################

		if (params.key?("save_in")) && plan != nil
			if check_actual == nil 
				user_actual =  Actual.create(:date => @date , :time_in => @time )
				user.actuals << user_actual
				plan.actuals << user_actual
				flash[:notice] = "check in success"
			elsif check_actual.time_in != nil
				flash[:notice] = "You have check in before !"
			end	
			redirect_to schedule_path
		elsif (params.key?("save_in"))
			flash[:notice] = "You don't have any plan !"

		end

		if (params.key?("save_out")) && plan != nil
			if check_actual != nil && check_actual.time_out == nil
				check_actual.update(:time_out => @time )
				act_out = check_actual.time_out
				plan_out = plan.time_out
				@ot = (act_out-plan_out+(12*3600))/(60*60)
				check_actual.update(:OT => @ot.ceil(1) )
				flash[:notice] = "check out success"

			elsif check_actual == nil 
				check_one = Actual.find_by(:date => (@date - (24*3600)) , :user_id => userid)
				plan_one = Plan.find_by(:user_id => userid , :date => (@date - (24*3600)))

				if plan_one != nil && check_one != nil && check_one.time_in != nil && check_one.time_out == nil
					check_one.update(:time_out => @time )
					act_out = check_one.time_out
					
					plan_out = plan_one.time_out
					@ot = (act_out-plan_out+(12*3600))/(60*60)
					check_one.update(:OT => @ot.ceil(1) )
					flash[:notice] = "check out success"

				else
					flash[:notice] = "You haven't check in before !"
				end

			else
				flash[:notice] = "You have check out before !"
			end	

			redirect_to schedule_path



		elsif (params.key?("save_out"))

			check_two = Actual.find_by(:date => (@date - (24*3600)) , :user_id => userid)
			plan_two = Plan.find_by(:user_id => userid , :date => (@date - (24*3600)))

			if plan_two != nil && check_two != nil && check_two.time_in != nil && check_two.time_out == nil

				check_two.update(:time_out => @time )
				act_out = check_two.time_out
					
				plan_out = plan_two.time_out
				@ot = (act_out-plan_out+(12*3600))/(60*60)
				check_two.update(:OT => @ot.ceil(1) )
				flash[:notice] = "check out success"
				redirect_to schedule_path
				
			else
				flash[:notice] = "You don't have any plan !"
			end
		end

	end
end
