class Debit < ActiveRecord::Base
	attr_accessible :item_purchased, :debit_category_id, :reason, :number_of_consumers, :names_of_consumers, :date_purchased, :account_id, :reimbursement_date, :amount

	#Relationships
	belongs_to :account
	belongs_to :debit_category
	
	#Validations
	validates_presence_of :item_purchased, :reason, :debit_category_id, :date_purchased
	
	#validates_numericality_of :amount
	validate :valid_amount
	validates_format_of :amount, :with => /^\d\d*$/
	validates_numericality_of :amount, :greater_than => 0 
	
	validate :valid_number_of_consumers
	validate :valid_names_of_consumers
	

	#Named Scopes
	#orders debits by debit_id asscending 
    named_scope :all, :order => "account_id"
	
    # get all the debits by a particular account
    named_scope :for_account, lambda { |account| { :conditions => ['account_id = ?', account] } }
	
	# get all debits with reimbursement_date = nil for an account
	named_scope :not_reimbursed_for_account, lambda { |account| {:conditions => ['account_id = ? AND reimbursement_date is NULL', account] } }
	
	
	def reimburse
		self.reimbursement_date = DateTime.now
	end
	
	def valid_number_of_consumers
		if self.debit_category.category.eql?("Food")
			validates_numericality_of :number_of_consumers
		end
		return
	end
	
	def valid_names_of_consumers
		if !number_of_consumers.nil?
			if self.number_of_consumers > 5
				validates_presence_of :names_of_consumers
			end
		else
			validates_presence_of :names_of_consumers
		end
	end
	
	def valid_amount
		unless self.account.balance - amount > 0
			errors.add_to_base('this amount would put you over budgit')
		end
	end
	
	
	

end
