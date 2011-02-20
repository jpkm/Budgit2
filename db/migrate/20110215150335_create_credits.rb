class CreateCredits < ActiveRecord::Migration
  def self.up
    create_table :credits do |t|
      t.integer :credit_category_id
      t.datetime :date
      t.integer :account_id
      t.integer :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :credits
  end
end
