class EmployeesController < ApplicationController

	def show
		@time = Time.current
		day = Time.current.strftime("%Y-%m-%d")
		@date = day.to_time 

		# id_user = current_user.id
		userid = current_user.id
		user = User.find_by_id(userid)
		@all_plans = Plan.where(:user_id => userid).order("date DESC")
		plan = Plan.find_by(:user_id => userid , :date => @date)

		check_actual = Actual.find_by(:date => @date , :user_id => userid)

		if (params.key?("save_in"))
			if check_actual == nil
				if plan != nil
					user_actual =  Actual.create(:date => @date , :time_in => @time )
					user.actuals << user_actual
					plan.actuals << user_actual
					flash[:notice] = "check in success"
				else
					flash[:warning] = "You don't have plan for today."
				end
			else
				flash[:warning] = "You have just checked in for today."
			end
			redirect_to schedule_path
		end

		if (params.key?("save_out"))
			if check_actual != nil
				flash[:warning] = "You have just checked out for today."
			else
				if plan != nil
					user_actual =  Actual.create(:date => @date , :time_out => @time )
					user.actuals << user_actual
					plan.actuals << user_actual
					act_out = check_actual.time_out
					plan_out = plan.time_out
					@ot = (act_out-plan_out+(12*3600))/(60*60)
					flash[:notice] = "check out success"
				else
					flash[:warning] = "You don't have plan for today."
				end
			end	
			redirect_to schedule_path
		end
		
	end
end
