class Role < ActiveRecord::Base
	attr_accessible :name
	
	#Relationships
	has_many :assignments
	
	#Validations
	validate :r
	
	def r
		rs = []
		for r in Role.all
			rs << r.name.downcase.strip
		end
		
		unless name.nil? || name.empty?
			if rs.include?(name)
				validates_uniqueness_of :name
			end
		else
			validates_presence_of :name
		end
	end	
	
end
