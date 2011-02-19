class Club < ActiveRecord::Base
	attr_accessible :name

	#Relationships
	has_many :accounts, :dependent => :destroy
	has_many :assignments
	has_many :users, :through => :assignments
	
	#Validations
	validates_presence_of :name
	
	#Named Scopes
	#orders clubs by club_id
	named_scope :all, :order => "name"
	
end
