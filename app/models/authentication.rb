class Authentication < ActiveRecord::Base
	belongs_to :user
	validates  :uid , presence: true, uniqueness: {case_sensitive: false}

end
