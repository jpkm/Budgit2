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
			if cats.include?(category)
				validates_uniqueness_of :category
			end
		else
			validates_presence_of :category
		end
	end	

end
