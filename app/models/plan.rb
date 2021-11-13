class Plan < ApplicationRecord

	belongs_to :user

	validates :user_id, :presence=>true
	validates :OT, :presence=>true
	validate :check_time_in_out # check time in less than time out

	def check_time_in_out
		errors.add(:time_in, :time_out, 'time in must be less than time out') if time_in > time_out
	end

end
