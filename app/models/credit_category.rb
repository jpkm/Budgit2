class CreditCategory < ActiveRecord::Base
	attr_accessible :category
	
	##Relationships
	has_many :credits
	
	## Validations
	validate :cc
	
	## Named Scopes
	named_scope :all, :order => "id ASC"
		
	
	def cc
		cats = []
		for c in CreditCategory.all
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
