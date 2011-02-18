class CreditCategory < ActiveRecord::Base
	attr_accessible :category
	
	has_many :credits
	
	validates_presence_of :category
end
