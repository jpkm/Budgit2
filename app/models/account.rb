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
	named_scope :is_active_for_club, lambda { |club| {:conditions => ['club_id = ? AND active = ?', club, true] } }
	
	
end
