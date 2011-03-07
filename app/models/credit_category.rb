class CreditCategory < ActiveRecord::Base
	attr_accessible :category
	
	has_many :credits
	
	validates_presence_of :category
	
	named_scope :all, :order => "id ASC"
	named_scope :except_initial, :conditions => 'category is not Inital' 
	
	
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
