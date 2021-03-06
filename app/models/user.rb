class User < ActiveRecord::Base
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :email, :password, :password_confirmation, :first_name, :last_name
  before_save :prepare_password

  #Relationships
  has_many :assignments
  has_many :roles, :through => :assignments
  has_many :clubs, :through => :assignments
  
  #Validations
  validates_uniqueness_of :email, :allow_blank => false
  validate :un
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :first_name, :last_name, :on => :create
  validates_confirmation_of :password
  
  #Custome Validations
	def un
		names = []
		for u in User.all
			names << u.username.downcase.strip
		end
		
		unless username.nil? || username.empty?
			if names.include?(username.downcase.strip)
				errors.add_to_base('Username already used')
			else
				validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => false, :message => "should only contain letters, numbers, or .-_@"
			end
		else
			validates_presence_of :username
		end
	end	
 
	#Methods
	#counts number of active assignments for user
	def count_active_assignments
		sum = 0
		for a in assignments
			if a.active?
				sum = sum + 1
			end
		end
		return sum
	end
 
	#formats user name
	def name
		self.first_name + " " + self.last_name
	end
	
	#checks if user assignments are admin  
	def is_admin?
		assignments.each do |assignment|
			if assignment.role.name.downcase.eql?("system admin")
				return true
			end
		end
		return false
	end
	
	#checks if user assignments are admin  
	def is_director?
		assignments.each do |assignment|
			if assignment.role.name.downcase.eql?("director")
				return true
			end
		end
		return false
	end
	
	#checks if user is VP  
	def is_vp?
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
			if assignment.role.name.downcase.eql?("student affairs")
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
			if assignment.role.name.downcase.eql?("club leader")
				return true
			end
		end
		return false
	end
	
	#checks if user has active assignments
	def has_active_assignment?
		for assignment in assignments
			if assignment.active
				return true
			end
		end
		return false
	end
	
	#return users who are aren't the sysad, vp, or director and either have no previose assignments or have assignments with this role   
	def self.free_users(club, role)
		p role
		p club
		free_users = []
		for u in User.all
			should_add = true
			if u.assignments.nil? || u.assignments.empty?
				free_users << u
			else
				for assignment in u.assignments
					if assignment.club_id == club.id || assignment.role.name.downcase.eql?("system admin") || assignment.role.name.downcase.eql?("vp of finance") || assignment.role.name.downcase.eql?("director") || !assignment.role.name.eql?(role.name)
						should_add = false
					end
				end
				if should_add 
					free_users << u
				end
			end
		end
		free_users
	end
	
	#gets all clubs a user has an active assignment to
	def get_clubs
		unless self.is_admin? || self.is_vp? || self.is_director?
			clubs = []
			if has_active_assignment? && !assignments.nil?
				for assignment in assignments
					clubs << assignment.club
				end
				return clubs
			end
		end
	end
	
	#gets all active accounts for club you are assigned to
	def get_accounts
		@accounts = []
		for club in self.get_clubs
			p club.current_account
			unless club.current_account.nil?
				@accounts << club.current_account
			end
		end
		return @accounts
	end
 
	#Stuff it came with
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

	def prepare_password
		unless password.blank?
			self.password_salt = BCrypt::Engine.generate_salt
		self.password_hash = encrypt_password(password)
		end
	end
end
