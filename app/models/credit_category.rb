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
			if cats.include?(category.downcase.strip)
				errors.add_to_base('Category already used')
			else
				test = category.strip
				if test.blank?
					return errors.add_to_base('Name was invalid')
				end
			
			end
		else
			validates_presence_of :category
		end
	end	
	
	
	def self.except_initial
		except = []
		for creditcategory in CreditCategory.all
			unless creditcategory.category.downcase.eql?("initial")
				except << creditcategory
			end
		end
		return except
	end
	
end
