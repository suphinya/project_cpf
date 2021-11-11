class EmployeesController < ApplicationController

	def show
		@time = Time.current
		day = Time.current.strftime("%Y-%m-%d")
		@date = day.to_time 

		name_user = current_user.name
		userid = current_user.id
		user = User.find_by_name(name_user)
		plan = Plan.find_by(:user_id => userid , :date => @date)

		check_actual = Actual.find_by(:date => @date , :user_id => userid)

		if (params.key?("save_in"))
			if check_actual == nil
				user_actual =  Actual.create(:date => @date , :time_in => @time )
				user.actuals << user_actual
				plan.actuals << user_actual
			else
				check_actual.update(:time_in => @time)
			end	
			flash[:notice] = "check in success"
			redirect_to schedule_path
		end

		if (params.key?("save_out"))
			if check_actual != nil
				check_actual.update(:time_out => @time )
				act_out = check_actual.time_out
				plan_out = plan.time_out
				@ot = (act_out-plan_out)/(60*60)
				check_actual.update(:OT => @ot )
			else
				user_actual =  Actual.create(:date => @date , :time_out => @time )
				user.actuals << user_actual
				plan.actuals << user_actual
			end	
			flash[:notice] = "check out success"
			redirect_to schedule_path
		end
		
	end
end
