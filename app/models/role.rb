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
			name.downcase!
			name.strip!
			if rs.include?(name)
				errors.add_to_base('Role already used')
			end
		else
			validates_presence_of :name
		end
	end	
	
end
