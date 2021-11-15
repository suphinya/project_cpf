class User < ApplicationRecord

	has_secure_password
	has_many :plans
	has_many :actuals

	validates :username, :presence=>true
	validates :password_digest, :presence=>true
	validates :name, :presence=>true
	validates :surname, :presence=>true
	validates :position, :presence=>true

end
