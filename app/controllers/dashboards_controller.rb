class DashboardsController < ApplicationController

	def index
	end

	def edit
		@department_name = params[:id]
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
			date = Time.current.strftime("%Y-%m-%d")
			@t_in = (date + ' '+ @select[0..4]).to_time

			@calender = params[:date_work].values[0]
			@status = true
		end

	end

end
