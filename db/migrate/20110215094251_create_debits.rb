class CreateDebits < ActiveRecord::Migration
  def self.up
    create_table :debits do |t|
      t.text :item_purchased
      t.integer :debit_category_id
      t.text :reason
	  t.text :vendor
      t.integer :number_of_consumers
      t.text :names_of_consumers
      t.date :date_purchased
      t.integer :account_id
      t.integer :amount
      t.date :reimbursement_date
	  t.string :status
	  

      t.timestamps
    end
  end

  def self.down
    drop_table :debits
  end
end
