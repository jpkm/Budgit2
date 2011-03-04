class Debit < ActiveRecord::Base
	attr_accessible :item_purchased, :debit_category_id, :reason, :number_of_consumers, :names_of_consumers, :date_purchased, :account_id, :reimbursement_date, :amount

	#Relationships
	belongs_to :account
	belongs_to :debit_category
	
	#Validations
	validates_presence_of :item_purchased, :reason, :debit_category_id, :date_purchased
	validates_numericality_of :amount

	#Named Scopes
	#orders debits by debit_id asscending 
    named_scope :all, :order => "id ASC"
	
    # get all the debits by a particular account
    named_scope :for_account, lambda { |account| { :conditions => ['account_id = ?', account] } }
	# get all debits with reimbursement_date = nil for an account
	
	#named_scope :not_reimbursed_for_account, lambda { |account| {:conditions => ['account_id = ? AND reimbursement_date is NULL', account] } }
	# get all unreimbursed debits
	#named_scope :not_reimbursed, :conditions => ['reimbursement_date is NULL']
	
	#if reimbursement_date is 'nil' defect is not reimbursed
	#def reimbursed?
	#  self.reimbursement_date != "nil"
	#end
	
	#def reimburse
	#	self.reimbursement_date = DateTime.now
	#end
	
	def total_debits_per_account (account)
		( Debit.for_account(account) ).amount.sum
	end

end
