class Club < ActiveRecord::Base
	attr_accessible :name

	#Relationships
	has_many :accounts, :dependent => :destroy
	has_many :assignments
	has_many :users, :through => :assignments
	
	#Validations
	validates_presence_of :name
	validates_uniqueness_of :name
	
	#Named Scopes
	#orders clubs by club_id
	named_scope :all, :order => "name"
	# get all the projects by a particular user
    named_scope :for_user,  lambda { |user_id| { :joins => :assignments, :conditions => ['user_id = ?', user_id] } }
	
	def current_account
		for account in self.accounts
			if(account.active)
				return account
			end
		end
	end
	#######################################################
	# Probably don't need this
	# returns faculty advisor
	def faculty_advisor
		assignments.each do |assignment|
			if assignment.role.name.eql?("Faculty Advisor")
				return assignment.user.name
			end
		end
		return false
	end
	
	# returns club leader
	def club_leader
		for assignment in self.assignments
			if assignment.role.name.eql?("Club Leader")
				return assignment.user.name
			end
		end
		return false
	end
	######################################################
end
