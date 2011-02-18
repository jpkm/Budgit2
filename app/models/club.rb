class Club < ActiveRecord::Base
	has_many :accounts
	has_many :assignments
	has_many :users, :through => :assignments
	
	validates_presence_of :name
	
end
