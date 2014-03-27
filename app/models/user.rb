#bcrypt will generate the password hash
require 'bcrypt'


class User

	include DataMapper::Resource

	property :id, Serial
	property :email, String, :unique => true, :message => "The email is already taken"

	#this will store both the password and the salt.
	#It's Text and not String because String holds 50 characters by default.
	#and it's not enough for the hash and salt.

	property :password_digest, Text

	#when assigned the password, we don't store it directly.
	#Instead, we generate a password digest, that looks like this:
	#"$2a$10$vI8aWBnW3fID.ZQ4/zo1G.q1lRps.9cGLcZEiGDMVr5yUP1KUOYTa"
	#and save it in the database. This digest, provided by bcrypt, has both the password hash and the salt.
	#We save it to the database instead of the plain password for security reasons.

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	#The reason we need the reader for :password and :password_confirmation 
	#is that datamapper should have access to both values to make sure they are the same.
	#The reason we need the writer for :password_confirmation is 
	#that we're now passing the password confirmation to the model in the controller.
	attr_reader :password
	attr_accessor :password_confirmation

	#this is datamapper's method of validating the model.
	# The model will not be saved unless both password and password_confirmation are the same.
	# Read more about it in the documentation. # http://datamapper.org/docs/validations.html
	validates_confirmation_of :password, :message => "Sorry, your passwords don't match" 
	
	#This datamapper validation will check if a record with this email exists before trying to create a new one
	#In datamapper's case, creating a unique index (see just above) automatically implies the necessity of the validation, 
	#so this code would be unnecessary.
	validates_uniqueness_of :email

	def self.authenticate(email, password)
	  # that's the user who is trying to sign in
	  user = first(:email => email)
	  # if this user exists and the password provided matches
	  # the one we have password_digest for, everything's fine
	  #
	  # The Password.new returns an object that overrides the ==
	  # method. Instead of comparing two passwords directly
	  # (which is impossible because we only have a one-way hash)
	  # the == method calculates the candidate password_digest from
	  # the password given and compares it to the password_digest
	  # it was initialised with.
	  # So, to recap: THIS IS NOT A STRING COMPARISON 
	  if user && BCrypt::Password.new(user.password_digest) == password
	    # return this user
	    user
	  else
	    nil
	  end
	end


end

