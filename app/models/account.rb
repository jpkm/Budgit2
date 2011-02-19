class Account < ActiveRecord::Base
	attr_accessible :club_id, :year

	#Relationships
	belongs_to :club
	has_many :debits
	has_many :credits
	
	#Validations
	validates_presence_of :club_id
	validates_numericality_of :year
	
	#Named Scopes
	# get all accounts for a particular club_id
	named_scope :by_club_id, lambda { |club_id| { :conditions => ['club_id = ?', club_id] } }
	
end
