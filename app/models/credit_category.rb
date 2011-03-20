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
				validates_format_of :first_name, :middle_name, :last_name, :with => /^[A-Za-z]+$/i, :allow_blank => false, :message => "should only contain letters"
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
