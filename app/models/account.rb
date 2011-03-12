class Account < ActiveRecord::Base
	attr_accessible :club_id, :year, :active

	#Relationships
	belongs_to :club
	has_many :debits
	has_many :credits
	
	#Validations
	validates_presence_of :club_id
	validates_numericality_of :year
	
	#Named Scopes
	
	# get all accounts for a particular club_id
	named_scope :for_club, lambda { |club_id| { :conditions => ['club_id = ?', club_id] } }
	# get all active accounts for a particular club_id 
	named_scope :inactive_for_club, lambda { |club| {:conditions => ['club_id = ? AND active = ?', club, false] } }
	# get all credit categores for credits attached to this account
	#named_scope :has_initial
	
	
	def balance
		sum = 0 - self.sum_debits + self.sum_credits
		return sum
	end
	
	#### returns the sum of all debits for this account.
	def sum_debits
		sum = 0
		for debit in self.debits
			sum = sum + debit.amount
		end
		return sum
	end
	
	#### returns the sum of all the credits for this account.
	def sum_credits
		sum = 0
		for credit in self.credits
			sum = sum + credit.amount
		end
		return sum
	end
	
	#### checks if the account has a credit with creditcategory type of "Initial"
	def has_inital?
		for credit in credits
			if credit.credit_category.category.eql?("Inital")
				return true
			end
		end
		return false
	end
	
	#### returns all debits who's reimbusement_date is nil
	def unreimbursed
		unreimbursed = []
		for debit in self.debits
			if debit.reimbursement_date.nil?
				unreimbursed << debit
			end
		end
		return unreimbursed
	end
	
end
