class EmployeesController < ApplicationController

	def show
		@time = Time.current
		day = Time.current.strftime("%Y-%m-%d")
		@date = day.to_time 

		userid = current_user.id
		user = User.find(userid)
		plan = Plan.find_by(:user_id => userid , :date => @date)
		@all_plans = Plan.where(:user_id => userid).order("date DESC")

		check_actual = Actual.find_by(:date => @date , :user_id => userid)

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
				check_actual.update(:OT => @ot )
				flash[:notice] = "check out success"
			else
				flash[:notice] = "You have check out before !"
			end	
			redirect_to schedule_path
		elsif (params.key?("save_out"))
			flash[:notice] = "You don't have any plan !"
		end
		
	end
end
