class AddDefaultUser < ActiveRecord::Migration
  def self.up
	admin = User.new
	admin.username = "system"
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

