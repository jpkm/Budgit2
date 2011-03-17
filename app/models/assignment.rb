class Assignment < ActiveRecord::Base
	attr_accessible :club_id, :user_id, :role_id
	
	#Relationships
	belongs_to :club
	belongs_to :role
	belongs_to :user
	
	#Validations
	validates_presence_of :role_id, :user_id
	#validates_uniqueness_of :user_id, :scope => [:club_id, :role_id]
	#validate :valid_assignment
	
	
	#Named Scopes
	#get all the assignments for a user
    named_scope :for_user, lambda { |user| { :conditions => ['user_id = ?', user] } }
    #get all active assignments for a club_id
    named_scope :active_for_club, lambda { |club| { :conditions => ['club_id = ? AND active = ?', club, true] } }
	
	
	## returns true if there is an active assignment with role name of System Admin
	def valid_assignment
			if is_there_a_sysadmin? && role.name.eql?("System Admin")
				errors.add_to_base('there is already a system admin. You must deactiveate current sysad before assigning a new one')
			end
			if is_there_a_vp? && role.eql?("VP of Finance")
				errors.add_to_base('there is already a vp. You must deactiveate current vp before assigning a new one')
			end
	end
	
	
	def is_there_a_sysadmin?
		for assignment in Assignment.all
			if assignment.role.name.eql?("System Admin") && assignment.active
				return true
			end
		end
		return false
	end
	
	def is_there_a_vp?
		for assignment in Assignment.all
			if assignment.role.name.eql?("VP of Finance") && assignment.active
				return true
			end
		end
		return false
	end
	
	def roles_for_vp_and_sysadmin
		vp_and_sysadmin_roles = []
		for role in Role.all
			if role.name.eql?("System Admin") || role.name.eql?("VP of Finance") 
				vp_and_sysadmin_roles << role
			end
		end
		return vp_and_sysadmin_roles
	end
	
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
		
end
