class Club < ActiveRecord::Base
	attr_accessible :name, :club_key, :active

	#Relationships
	has_many :accounts, :dependent => :destroy
	has_many :assignments
	has_many :users, :through => :assignments
	
	#Validations
	validate :cn
	validates_uniqueness_of :club_key
	validates_presence_of :club_key, :allow_blank => false
	validates_format_of :club_key, :with => /^[0-9]{3}$/
	
	#Named Scopes
	#orders clubs by club_id
	scope :all, :order => "name"
	# get all the projects by a particular user
    scope :for_user,  lambda { |user_id| { :joins => :assignments, :conditions => ['user_id = ?', user_id] } }
	
	#Custome Validations
	def cn
		names = []
		for c in Club.all
			names << c.name.downcase.strip
		end
		
		unless name.nil? || name.empty?
			if names.include?(name.downcase.strip)
				errors.add_to_base('Name already taken')
			else
				#validates_format_of :name, :with => /^[-\w\._@]+$/i, :allow_blank => false, :message => "should only contain letters, numbers, or .-_@"
				test = name.strip
				if test.blank?
					return errors.add_to_base('Name was invalid')
				end
				
			end
			
		else
			validates_presence_of :name
		end
	end
		
	#Methods
	#determines current account balance for this club
	def current_balance
		account = self.current_account
		balance = account.balance
	end
	
	#determines current account for this club
	def current_account
		for account in self.accounts
			if(account.active)
				return account
			end
		end
		return nil
	end
	
	#returns roles that are available for club
	def roles_available
		available_roles = []
		for role in Role.all
			unless role.name.eql?("System Admin") || role.name.eql?("VP of Finance")
				available_roles << role
			end
		end
	
		club_roles = []
		for assignment in assignments
			if assignment.active?
				club_roles << assignment.role
			end
		end
		
		for role in club_roles
			available_roles.delete(role)
		end
		
		return available_roles
	end
	
	#returns all the not active (deactivated) accounts for club
	def deactivated
		count = 0
		for assignment in assignments
			unless assignment.active
				count = count + 1
			end
		end
		count
	end	
	
	#get the active leader for this club
	def get_leader
		for assignment in assignments
			if assignment.active && assignment.role.name.downcase.eql?("club leader")
				return assignment.user
			end
		end
		return nil
	end
	
	#get the active sa for this club
	def get_sa
		for assignment in assignments
			if assignment.active && assignment.role.name.downcase.eql?("student affairs")
				return assignment.user
			end
		end
		return nil
	end
	
	def has_current_account?
		for account in accounts
			if account.active
				return true
			end
		end
		return false
	end
	
	#get all debits for all current accounts from all club with amount < 250
	def self.get_all_under_250
		@under = []
		for club in Club.all
			unless club.current_account.nil?
				@under += club.current_account.get_under_250
			end
		end
		return @under
	end
	
	#get all debits for all current accounts from all club with amount > 250
	def self.get_all_over_250
		@over = []
		for club in Club.all
			unless club.current_account.nil?
				@over += club.current_account.get_over_250
			end
		end
		return @over
	end
	
end
