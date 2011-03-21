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
			if rs.include?(name.downcase.strip)
				errors.add_to_base('Role already used')
			else
				#validates_format_of :name, :with => /^[-\w\._@]+$/i, :allow_blank => false, :message => "should only contain letters, numbers, or .-_@"
				
				test = name.strip
				if test.blank?
					return errors.add_to_base('Name was invalid')
				end
				
			end
		else
			validates_presence_of :name
		end
	end	
	
end
