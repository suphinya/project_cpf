class User < ApplicationRecord

	has_many :plans

	has_secure_password

end
