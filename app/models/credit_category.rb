class CreditCategory < ActiveRecord::Base
	attr_accessible :category
	
	has_many :credits
	
	#validates_presence_of :category
	#validates_uniqueness_of :category
	validate :cc
	
	
	named_scope :all, :order => "id ASC"
		
	
	def cc
		cats = []
		for c in CreditCategory.all
			cats << c.category
		end
		
		unless category.nil? || category.empty?
			p category
			cc = category
			cc = category.downcase.strip
			p cc
			if cats.find(cc)
				validates_uniqueness_of :category
			end
		else
			validate_presence_of :category
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
