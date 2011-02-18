class Assignment < ActiveRecord::Base
	attr_accessible :clubID, :username, :roleID
	
	#Relationships
	belongs_to :club
	belongs_to :role
	belongs_to :user
	
	#Validations
	validates_presence_of :clubID, :roleID, :username
	
end
