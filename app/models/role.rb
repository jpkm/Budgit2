class Role < ActiveRecord::Base
	
	#Relationships
	has_many :assignments
	
	#Validations
	validates_presence_of :name
	
end
