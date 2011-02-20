class Debit < ActiveRecord::Base
	attr_accessible :item_purchased, :debit_category_id, :reason, :number_of_consumers, :names_of_consumers, :date_purchased, :account_id, :reimbursement_date

	#Relationships
	belongs_to :account
	belongs_to :debit_category
	
	#Validations
	validates_presence_of :item_purchased, :reason, :debit_category_id
	validates_numericality_of :debit_category_id, :date_purchased, :account_id, :amount
	
	#Named Scopes
	#orders debits by debit_id asscending 
    named_scope :all, :order => "id ASC"
    # get all the debits by a particular account
    named_scope :for_account, lambda { |account_id| { :conditions => ['account_id = ?', account_id] } }
	
end
