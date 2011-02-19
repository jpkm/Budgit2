class AddDefaultUser < ActiveRecord::Migration
  def self.up
	dad = User.new
	dad.username = "dad"
	dad.first_name = "dad"
	dad.middle_name = "a"
	dad.last_name = "d"
	dad.email = "dad@andrew.edu.com"
	dad.password = "budgit"
	dad.password_confirmation = "budgit"
	#dad.role = "admin"
	dad.save!
  end

  def self.down
	dad = User.find(:all, :conditions => ["username = ?", "dad"])
	User.delete dad
  end
end
