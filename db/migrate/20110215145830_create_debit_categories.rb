class CreateDebitCategories < ActiveRecord::Migration
  def self.up
    create_table :debit_categories do |t|
      t.boolean :active
      t.string :category

      t.timestamps
    end
  end

  def self.down
    drop_table :debit_categories
  end
end
