class Role < ActiveRecord::Base
	attr_accessible :name
	
	#Relationships
	has_many :assignments
	
	#Validations
	validate :r
	
	#Custome Validations
	def r
		rs = []
		for r in Role.all
			rs << r.name.downcase.strip
		end
		unless name.nil? || name.empty?
			if rs.include?(name.downcase.strip)
				errors.add_to_base('Role already used')
			else
				test = name.strip
				if test.blank?
					return errors.add_to_base('Name is invalid')
				end
				
			end
		else
			validates_presence_of :name
		end
	end	
	
	def self.get_sa
		for role in Role.all
			if role.name.downcase.eql?("student affairs")
				return role
			end
		end
	end
	
	def self.get_leader
		for role in Role.all
			if role.name.downcase.eql?("club leader")
				return role
			end
		end
	end
	
	
end
