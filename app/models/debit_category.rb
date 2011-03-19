class DebitCategory < ActiveRecord::Base
	attr_accessible :category

	##Relationships
	has_many :debits

	## Validations
	#validates_uniqueness_of :category
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
			#else
				#debit_category.save!
			end
		else
			validates_presence_of :category
		end
	end	

end
