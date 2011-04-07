class Account < ActiveRecord::Base
	attr_accessible :club_id, :date, :active

	#Relationships
	belongs_to :club
	has_many :debits
	has_many :credits
	
	#Validations
	validates_presence_of :club_id
	
	#Named Scopes
	# get all accounts for a particular club_id
	scope :for_club, lambda { |club_id| { :conditions => ['club_id = ?', club_id] } }
	# get all active accounts for a particular club_id 
	scope :inactive_for_club, lambda { |club| {:conditions => ['club_id = ? AND active = ?', club, false] } }
	
	
	def editing_balance(debit)
		sum = 0 - self.sum_editing_debits(debit) + self.sum_credits
		return sum
	end
	
	def sum_editing_debits(debit)
		sum = 0
		for debit in Debit.all_except(debit.id)
			sum = sum + debit.amount
		end
		return sum
	end
	
	
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
	def has_initial?
		for credit in credits
			if credit.credit_category.category.downcase.eql?("initial")
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
	
	def time_to_deactivate?
		if Date.today.month == 6
			return true
		end
		false
	end
	
	def year
		next_date = date.year + 1
		return "#{date.year}-#{next_date}"
	end
	
	def self.make_account(club_id)
		account = Account.new
		account.club_id = club_id
		account.date = Date.today
		account.active = true
		account.save!
	end
	
	def self.total
		total = 0
		for account in Account.all
			if account.active
				total = total + account.balance
			end
		end
		return total
	end
	
end
