class CreditCategory < ActiveRecord::Base
	attr_accessible :category
	
	has_many :credits

	
	named_scope :all, :order => "id ASC"
			
	
	
	def except_inital
		except = []
		for creditcategory in CreditCategory.all
			unless creditcategory.category.eql?("Inital")
				except << creditcategory
			end
		end
		return except
	end
	
end
