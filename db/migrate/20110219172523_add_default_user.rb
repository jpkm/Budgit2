class AddDefaultUser < ActiveRecord::Migration
  def self.up
	admin = User.new
	admin.username = "system"
	admin.first_name = "system"
	admin.middle_name = "system"
	admin.last_name = "admin"
	admin.email = "system@admin.com"
	admin.password = "system"
	admin.password_confirmation = "system"
	admin.save!
  end

  def self.down
	dad = User.find(:all, :conditions => ["username = ?", "system"])
	User.delete admin
  end
end

