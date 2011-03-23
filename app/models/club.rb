class Club < ActiveRecord::Base
	attr_accessible :name, :club_key

	#Relationships
	has_many :accounts, :dependent => :destroy
	has_many :assignments
	has_many :users, :through => :assignments
	
	#Validations
	validate :cn
	validates_uniqueness_of :club_key
	validates_presence_of :club_key, :allow_blank => false
	## allows 3 digit numbers that start with 0.
	validates_format_of :club_key, :with => /^[0-9]{3}$/
	
	#Named Scopes
	#orders clubs by club_id
	named_scope :all, :order => "name"
	# get all the projects by a particular user
    named_scope :for_user,  lambda { |user_id| { :joins => :assignments, :conditions => ['user_id = ?', user_id] } }
	
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
		
	def current_balance
		account = self.current_account
		balance = account.balance
	end
	
	def current_account
		for account in self.accounts
			if(account.active)
				return account
			end
		end
		return nil
	end
	
	#### returns roles that are available for club
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
	
	#### returns users without an active assignment who are aren't the sys or vp 
	def free_users
		free_users = []
		for u in User.all
			unless u.assignments.nil? || u.assignments.empty? 
				for assignment in u.assignments
					if assignment.active || assignment.role.name.downcase.eql?("system admin") || assignment.role.name.downcase.eql?("vp of finance") || assignment.club_id == self.id
						break
					end
				free_users << u
				end
			else
				free_users << u
			end
		end
		free_users
	end
end
