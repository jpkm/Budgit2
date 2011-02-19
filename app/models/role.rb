class Role < ActiveRecord::Base
	attr_accessible :name
	
	#Relationships
	has_many :assignments
	
	#Validations
	validates_presence_of :name
	
end
