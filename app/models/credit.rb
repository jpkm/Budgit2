class Credit < ActiveRecord::Base
	attr_accessible :credit_category_id, :date, :account_id, :amount

	# Relationships
	belongs_to :credit_category
	belongs_to :account
	
	# Validations
	validates_presence_of :credit_category
	validate :valid_amount
	
	#Scopes
	#orders debits by debit_id asscending 
    scope :all, :order => "id ASC"
    # get all the credits by a particular account
    scope :for_account, lambda { |account| { :conditions => ['account_id = ?', account] } }
	#get all credits with the credit_category of "initial" for an accoount
	scope :initial_for_account, lambda { |account| {:conditions => ['account_id = ? AND credit_category_id = ?', account, "Initial" ] } }
	
	#Custome Validations
	def valid_amount
		unless amount.nil?
			unless amount > 0
				validates_numericality_of :amount, :greater_than => 0
			end
		else
			validates_numericality_of :amount
		end
	end
	
	#Methods
	#calculates sum of all credits for an account
	def total_credits_per_account (account)
		( Credit.for_account(account) ).amount.sum
	end

end
