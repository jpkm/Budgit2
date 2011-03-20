class CreditCategory < ActiveRecord::Base
	attr_accessible :category
	
	##Relationships
	has_many :credits
	
	## Validations
	#validates_uniqueness_of :category
	validate :cc
	
	## Named Scopes
	named_scope :all, :order => "id ASC"
		
	
	def cc
		cats = []
		for c in CreditCategory.all
			cats << c.category.downcase.strip
		end
		
		unless category.nil? || category.empty?
			#category.downcase!
			#category.strip!
			if cats.include?(category.downcase.strip)
				errors.add_to_base('Category already used')
			end
		else
			validates_presence_of :category
		end
	end	
	
	
	def except_inital
		except = []
		for creditcategory in CreditCategory.all
			unless creditcategory.category.downcase.eql?("inital")
				except << creditcategory
			end
		end
		return except
	end
	
end
