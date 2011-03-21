class DebitCategory < ActiveRecord::Base
	attr_accessible :category

	##Relationships
	has_many :debits

	## Validations
	validate :dd
	

	#Named Scopes
	#orders debits by debit_id asscending 
	named_scope :all, :order => "id ASC"
	
	def dd
		cats = []
		for c in DebitCategory.all
			cats << c.category.downcase.strip
		end
		
		unless category.nil? || category.empty?
			if cats.include?(category.downcase.strip)
				errors.add_to_base('Category already used')
			else
				#validates_format_of :category, :with => /^[A-Za-z]+$/i, :allow_blank => false, :message => "should only contain letters"
				
				test = category.strip
				if test.blank?
					return errors.add_to_base('Name was invalid')
				end
			end
		else
			validates_presence_of :category
		end
	end	

end
