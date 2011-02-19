class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.integer :year
      t.integer :club_id

      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
