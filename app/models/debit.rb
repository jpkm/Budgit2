class Debit < ActiveRecord::Base
	attr_accessible :item_purchased, :debit_category_id, :reason, :number_of_consumers, :names_of_consumers, :date_purchased, :account_id, :reimbursement_date, :amount, :vendure

	#Relationships
	belongs_to :account
	belongs_to :debit_category
	
	#Validations
	validates_presence_of :item_purchased, :reason, :debit_category_id, :date_purchased, :vendure
	validate :valid_amount, :on => :create
	validate :valid_amount_editing, :on => :update
	validate :valid_number_of_consumers
	validates_format_of :vendure, :with => /^[-\w\._@]+$/i, :allow_blank => false, :message => "should only contain letters, numbers, or .-_@"
	

	#Named Scopes
	#orders debits by debit_id asscending 
    named_scope :all, :order => "account_id"
	#gets all debits except this debit 
	named_scope :all_except, lambda {|id| { :conditions => ['id != ?', id] } } 
	
    # get all the debits by a particular account
    named_scope :for_account, lambda { |account| { :conditions => ['account_id = ?', account] } }
	# get all debits with reimbursement_date = nil for an account
	named_scope :not_reimbursed_for_account, lambda { |account| {:conditions => ['account_id = ? AND reimbursement_date is NULL', account] } }
	
	
	def reimburse
		self.reimbursement_date = DateTime.now
	end
	
	def valid_number_of_consumers
		unless debit_category.nil?
			if debit_category.category.eql?("Food")
				validates_presence_of :number_of_consumers
				valid_names_of_consumers
			end
		end
		return
	end
	
	def valid_names_of_consumers
		unless number_of_consumers.nil?
			if number_of_consumers > 0
				if number_of_consumers <= 5
					validates_presence_of :names_of_consumers
				end
			else
				validates_numericality_of :number_of_consumers, :greater_than => 0 
			end
		end
		return
	end
	
	## will throw an error unless amount is > 0 and adding the debit will not put the account over budget
	## could take in a condition for editing
	def valid_amount
		unless amount.nil?
			if amount > 0
				unless account.balance - amount >= 0
					errors.add_to_base('this amount would put you over budget')
				end
			else
				validates_numericality_of :amount, :greater_than => 0
			end
		else
			validates_numericality_of :amount
		end
	end
	
	def valid_amount_editing
		unless amount.nil?
			if amount > 0
				unless account.editing_balance(self) - amount >= 0
					errors.add_to_base('this amount would put you over budget')
				end
			else
				validates_numericality_of :amount, :greater_than => 0
			end
		else
			validates_numericality_of :amount
		end
	end
	
	
end
