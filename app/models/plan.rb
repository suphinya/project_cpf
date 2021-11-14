
class Plan < ActiveRecord::Base
	belongs_to :user
	has_many :actuals

	validates :user_id, :presence=>true
	validates :time_in, :presence=>true
	validates :time_out, :presence=>true
	validates :date, :presence=>true
	validates :OT, :presence=>true
end
