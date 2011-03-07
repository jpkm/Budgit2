class Account < ActiveRecord::Base
	attr_accessible :club_id, :year, :active

	#Relationships
	belongs_to :club
	has_many :debits
	has_many :credits
	
	#Validations
	validates_presence_of :club_id
	validates_numericality_of :year
	
	#Named Scopes
	
	# get all accounts for a particular club_id
	named_scope :for_club, lambda { |club_id| { :conditions => ['club_id = ?', club_id] } }
	# get all active accounts for a particular club_id 
	named_scope :inactive_for_club, lambda { |club| {:conditions => ['club_id = ? AND active = ?', club, false] } }
	# get all credit categores for credits attached to this account
	#named_scope :has_initial
	
	# checks if the account has a credit with creditcategory type of "Initial"
	def has_inital?
		for credit in credits
			if credit.credit_category.category.eql?("Inital")
				return true
			end
		end
		return false
	end
	
	
	#def deactivate
	#	p self.active
	#	self.active = false
	#	p self.active
	#	
	#end
	
	
end
