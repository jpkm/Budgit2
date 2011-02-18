class Credit < ActiveRecord::Base
	belongs_to :credit_category :foreign_key => "type"
	belongs_to :account
	
	validates_numericality_of :categoryID, :date, :accountID, :amount
	
end
