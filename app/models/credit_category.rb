class CreditCategory < ActiveRecord::Base
	attr_accessible :category, :active
	
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
	
	# gives all active credit categories except 'initial'
	def self.except_initial
		except = []
		for creditcategory in CreditCategory.all
			if creditcategory.active
				unless creditcategory.category.downcase.eql?("initial")
					except << creditcategory
				end
			end
		end
		return except
	end
	
	#returns 'initial' credit category
	def self.get_initial
		for creditcategory in CreditCategory.all
			if creditcategory.category.downcase.eql?("initial")
				return creditcategory
			end
		end
		return
	end
	
end
