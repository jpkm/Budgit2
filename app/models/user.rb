class User < ActiveRecord::Base
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :email, :password, :password_confirmation, :first_name, :middle_name, :last_name
  before_save :prepare_password

  #Relationships
  has_many :assignments
  has_many :roles, :through => :assignments
  has_many :clubs, :through => :assignments
  
  #Validations
  #validate :un
  validates_presence_of :first_name, :middle_name, :last_name
  validates_uniqueness_of :email, :allow_blank => true
  validate :un
  validates_format_of :first_name, :middle_name, :last_name, :with => /w/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  #validates_format_of :first_name, :middle_name, :last_name, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  
  
	def un
		p username
		names = []
		for u in User.all
			names << u.username.downcase.strip
		end
		p names
		
		unless username.nil? || username.empty?
			if names.include?(username.downcase.strip)
				errors.add_to_base('Username already used')
			else
				validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
			end
		else
			validates_presence_of :username
		end
	end	
 

  # login can be either username or email address
  def self.authenticate(login, pass)
	login = login.strip
	pass = pass.strip
    user = find_by_username(login)
    return user if user && user.password_hash == user.encrypt_password(pass)
  end

  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end

  #private

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end
  
   # get user name
   def name
    first_name + " " + middle_name + " " + last_name
   end
	
	#checks if user assignments are admin  
	def is_admin?
		assignments.each do |assignment|
			p assignment.role.name
			if assignment.role.name.downcase.eql?("system admin")
				return true
			end
		end
		return false
	end
	
	#checks if user is VP  
	def is_VP?
		assignments.each do |assignment|
			if assignment.role.name.downcase.eql?("vp of finance")
				return true
			end
		end
		return false
	end
	
	#check is user is Student Affairs Advisor
	def is_affairs?
		assignments.each do |assignment|
			if assignment.role.name.downcase.eql?("student affairs advisor")
				return true
			end
		end
		return false
	end
	
	#check if user is Faculty Advisor
	def is_faculty?
		assignments.each do |assignment|
			if assignment.role.name.downcase.eql?("faculty advisor")
				return true
			end
		end
		return false
	end
	
	#check if user is Club Leader
	def is_leader?
		assignments.each do |assignment|
			if assignment.role.name.eql?("Club Leader")
				return true
			end
		end
		return false
	end
	
   
end
