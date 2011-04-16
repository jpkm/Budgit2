class CreateClubs < ActiveRecord::Migration
  def self.up
    create_table :clubs do |t|
      t.string :name
	  t.integer :club_key
	  t.boolean :active
      t.timestamps
    end
  end

  def self.down
    drop_table :clubs
  end
end
