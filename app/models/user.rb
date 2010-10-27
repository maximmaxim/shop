require 'digest/sha1'
class User < ActiveRecord::Base

validates_presence_of :name
validates_uniqueness_of :name
validates_presence_of :mail
validates_uniqueness_of :mail
validates_format_of :mail, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
:message => "Почтовый ящик не существует"


attr_accessor :password_confirmation
validates_confirmation_of :password
validates_length_of :password, :minimum => 5, :too_short => "Пароль должен быть более 4-х символов"

def validate
	errors.add_to_base("Пароль не введен") if hashed_password.blank?
end

def self.authenticate(name, password)
user = self.find_by_name(name)
	if user
	expected_password = encrypted_password(password, user.salt) 
		if user.hashed_password != expected_password
		   user = nil
		end
	end
user	
end

def self.find_users_to_show
find(:all, :order=>"id")
end

def password
@password
end

def password=(pwd)
@password = pwd
create_new_salt
self.hashed_password = User.encrypted_password(self.password, self.salt)
end


private 
	def self.encrypted_password(password, salt)
	  string_to_hash = password + "wibble" + salt
	  Digest::SHA1.hexdigest(string_to_hash)
	end

	def create_new_salt
	self.salt = self.object_id.to_s + rand.to_s
	end

end
