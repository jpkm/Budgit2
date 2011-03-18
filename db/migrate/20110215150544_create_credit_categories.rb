class CreateCreditCategories < ActiveRecord::Migration
  def self.up
    create_table :credit_categories do |t|
      t.boolean :active = true
      t.string :category

      t.timestamps
    end
  end

  def self.down
    drop_table :credit_categories
  end
end
