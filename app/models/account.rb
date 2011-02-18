class Account < ActiveRecord::Base
	belongs_to :club
	has_many :debits
	has_many :credits
	
	validates_presence_of :clubID
	validates_numericality_of :year
	
	
end
