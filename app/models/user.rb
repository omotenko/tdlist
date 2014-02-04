class User < ActiveRecord::Base
	has_many :messages, dependent: :destroy
	has_many :authentications
	before_save {self.email = email.downcase}
	validates :name,  presence: true, length: { maximum: 30 }
	EMAIL_REGEX = /\A(\w+([-.][A-Za-z0-9]+)*)@[\w]+(\.[a-z]{2,})+\Z/i
    validates :email, presence: true, 
    				  format: { with: EMAIL_REGEX },
                      uniqueness: {case_sensitive: false}
    has_secure_password

    validates :password, length: { minimum: 6 }

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
	    Digest::SHA1.hexdigest(token.to_s)
	end

	private

		def create_remember_token
		  self.remember_token = User.encrypt(User.new_remember_token)
		end

end

