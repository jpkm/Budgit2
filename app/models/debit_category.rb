class DebitCategory < ActiveRecord::Base
	attr_accessible :category
	
	has_many :debits
	
	validates_presence_of :category
end
