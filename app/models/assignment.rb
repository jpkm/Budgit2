class Assignment < ActiveRecord::Base
	attr_accessible :clubID, :username, :roleID
	
	#Relationships
	belongs_to :club
	belongs_to :role, :through => roleID
	belongs_to :user
	
	#Validations
	validates_presence_of :clubID, :roleID, :username
	
end
