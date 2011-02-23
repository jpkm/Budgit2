class Credit < ActiveRecord::Base
	attr_accessible :credit_category_id, :date, :account_id, :amount

	# Relationships
	belongs_to :credit_category
	belongs_to :account
	
	# Validations
	validates_numericality_of :credit_category_id, :date, :account_id, :amount
	
	#Named Scopes
	#orders debits by debit_id asscending 
    named_scope :all, :order => "id ASC"
    # get all the credits by a particular account
    named_scope :for_account, lambda { |account| { :conditions => ['account_id = ?', account] } }
	#get all credits with the credit_category of "initial" for an accoount
	named_scope :initial_for_account, lambda { |account| {:conditions => ['account_id = ? AND credit_category_id = ?', account, "Initial" ] } }
	
end
