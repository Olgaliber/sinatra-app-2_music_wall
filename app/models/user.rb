require 'bcrypt'

class User < ActiveRecord::Base
	include BCrypt

	#getter
	def password
		@password ||= Password.new(password_hash)
	end

	#setter
	def password=(new_password)
		@password = Password.create(new_password)
		self.password_hash = @password
	end

end