class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.integer :role_id
      t.integer :club_id
      t.string :user_id
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :assignments
  end
end
