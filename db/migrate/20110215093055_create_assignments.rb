class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.integer :roleID
      t.integer :clubID
      t.string :username
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :assignments
  end
end
