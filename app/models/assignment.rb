class Assignment < ActiveRecord::Base
	attr_accessible :club_id, :user_id, :role_id
	
	#Relationships
	belongs_to :club
	belongs_to :role
	belongs_to :user
	
	#Validations
	validates_presence_of :role, :user
	validate :valid_assignment

	#Scopes
	#get all the assignments for a user
    scope :for_user, lambda { |user| { :conditions => ['user_id = ?', user] } }
    #get all active assignments for a club_id
    scope :active_for_club, lambda { |club| { :conditions => ['club_id = ? AND active = ?', club, true] } }
	
	#Custume Validations
	#returns true if there is not an active assignment with role name of System Admin or VP
	def valid_assignment
		unless role.nil? || user.nil?
			if is_there_a_sysadmin? && role.name.eql?("System Admin")
				errors.add_to_base('There is already a '+role.name+'. You must deactivate the current '+role.name+' before assigning a new one')
			end
			
			if is_there_a_vp? && role.name.eql?("VP of Finance")
				errors.add_to_base('There is already a '+role.name+'. You must deactivate the current '+role.name+' before assigning a new one')
			end

			unless (role.name.eql?("VP of Finance") || role.name.eql?("System Admin"))
				if(is_there_another_active(self))
					errors.add_to_base('There is already a '+role.name+'. You must deactivate the current '+role.name+' before assigning a new one')
				end	
			end
		end
	end
	
	#Methods
	#determines if an identical assignment as the parameter is already exists
	def is_there_another_active(assignment)
		for other in Assignment.all
			unless other.id == assignment.id
				if other.role.name.eql?(assignment.role.name)
					if other.club.name.eql?(assignment.club.name)
						return true if other.active
					end
				end
			end
		end
		return false
	end
	
	#determines if there is an active assignment for 'System Admin'
	def is_there_a_sysadmin?
		for assignment in Assignment.all
			if assignment.role.name.eql?("System Admin") && assignment.active
				return true
			end
		end
		return false
	end
	
	#determines if there is an active assignment for 'System Admin'
	def is_there_a_vp?
		for assignment in Assignment.all
			if assignment.role.name.eql?("VP of Finance") && assignment.active
				return true
			end
		end
		return false
	end
	
	#returns an array of roles for the System Admin and VP
	def roles_for_vp_and_sysadmin
		vp_and_sysadmin_roles = []
		for role in Role.all
			if role.name.eql?("System Admin") || role.name.eql?("VP of Finance") 
				vp_and_sysadmin_roles << role
			end
		end
		return vp_and_sysadmin_roles
	end
	
	#returns an array of users who do not have an active assignment
	def available_users
		free_users = []
		for user in User.all
			unless user.assignments.nil? || user.assignments.empty?
				for assignment in user.assignments
					if assignment.active
						break
					end
				free_users << user
				end
			else
				free_users << user
			end
		end
		return free_users
	end
	
	def self.assign_me(club,role)
		assignment = Assignment.new
		assignment.club_id = club.id
		assignment.role_id = Role.get_sa.id
		assignment.active = true
		assignment.save!
	end
	
		
end
