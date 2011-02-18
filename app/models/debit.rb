class Debit < ActiveRecord::Base
	belongs_to :account
	belongs_to :debit_category
	
	validates_presence_of :item_purchased, :reason
	validates_numericality_of :categoryID, :date_purchased, :accountID, :amount
	
	
end
