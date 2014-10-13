class User < ActiveRecord::Base
	validates :login, :presence => true

	attr_accessor :password

	def password
		@password
	end

	def password=(pass)
		return unless pass
		@password = pass
		generate_password(pass)
		# encrypt_password
	end

	def self.authentication(login, password)
		user = User.find_by_login(login)
		if user && Digest::SHA2.hexdigest(password + user.salt) == user.hashed_password
			return user
		end
		false
	end
	private
	def generate_password(pass)
		salt = Array.new(10){rand(1024).to_s(36)}.join
		self.salt, self.hashed_password = salt, Digest::SHA256.hexdigest(pass + salt)
	end

  def encrypt_password
    self.password_salt = self.object_id.to_s + rand.to_s
    self.password_hash = Digest::SHA2.hexdigest(password + password_salt)
  end

end
