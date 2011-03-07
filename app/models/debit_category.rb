class DebitCategory < ActiveRecord::Base
	attr_accessible :category

	has_many :debits

	validates_presence_of :category
	validates_uniqueness_of :category

	#Named Scopes
	#orders debits by debit_id asscending 
	named_scope :all, :order => "id ASC"

end
