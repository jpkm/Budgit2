class Credit < ActiveRecord::Base
	attr_accessible :credit_category_id, :date, :account_id, :amount

	belongs_to :credit_category
	belongs_to :account
	
	validates_numericality_of :credit_category_id, :date, :account_id, :amount
	
end
