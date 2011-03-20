class Club < ActiveRecord::Base
	attr_accessible :name

	#Relationships
	has_many :accounts, :dependent => :destroy
	has_many :assignments
	has_many :users, :through => :assignments
	
	#Validations
	validate :cn
	
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
					p assignment.active
					p assignment.role
					if assignment.active || assignment.role.eql?("system admin") || assignment.role.eql?("vp of finance")
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
			
	
		
		
		#active_club_users = []
		#for assignment in assignments
		#	if assignment.active
		#		active_club_users << assignment.user
		#	end
		#end
	
		#free_users =[]
		#for user in User.all
		#	for assignment in user.assignments
		#		unless assignment.active?
		#			unless assignment.role.name.eql?("System Admin") || assignment.role.name.eql?("VP of Finance")
		#				free_users << user
		#			end
		#		end
		#	end
		#end
		#return free_users
	#end
end
