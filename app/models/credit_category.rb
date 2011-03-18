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
			cats << c.category.downcase.strip
		end
		
		unless self.category.nil? || self.category.empty?
			p category
			p cats.find(category)
			if cats.find(self.category)
				#validates_uniqueness_of :category
			end
		else
			#validates_presence_of :category
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
