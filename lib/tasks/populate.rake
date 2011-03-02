namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    # Need two gems to make this work: faker & populator
    # Docs at: http://populator.rubyforge.org/
    require 'populator'
    # Docs at: http://faker.rubyforge.org/rdoc/
    require 'faker'
    
    # Step 1: clear any old data in the db
    [Assignment, Debit, Credit, DebitCategory, CreditCategory, User, Role, Club, Account].each(&:delete_all)
    
	# Step 2: add some Role to work with
		sys = Role.new
		sys.name = "System Admin"
		sys.save!
	  
		vp = Role.new
		vp.name = "VP of Finance"
		vp.save!
	  
		leader = Role.new
		leader.name = "Club Leader"
		leader.save!
	  
		faculty = Role.new
		faculty.name = "Faculty Advisor"
		faculty.save!
	  
		sa = Role.new
		sa.name = "Student Affairs"
		sa.save!
	  
	
	# Step 3.5: add X club
		x = Club.new
		x.name = "X"
		x.save!
    
    # Step 4: add System Admin
		sys = User.new
		sys.first_name = "system"
		sys.middle_name = "system"
		sys.last_name = "admin"
		sys.email = "system@admin.edu"
		sys.username = "system"
		sys.password = "system"
		sys.password_confirmation = "system"
		sys.save!
			
		vp = User.new
		vp.first_name = "vp"
		vp.middle_name = "vp"
		vp.last_name = "vp"
		vp.email = "v@p.edu"
		vp.username = "vp"
		vp.password = "vp"
		vp.password_confirmation = "vp"
		vp.save!
		
		leader = User.new
		leader.first_name = "leader"
		leader.middle_name = "leader"
		leader.last_name = "leader"
		leader.email = "leader@leader.edu"
		leader.username = "leader"
		leader.password = "leader"
		leader.password_confirmation = "leader"
		leader.save!
		
		sa = User.new
		sa.first_name = "sa"
		sa.middle_name = "sa"
		sa.last_name = "sa"
		sa.email = "sa@sa.edu"
		sa.username = "sa"
		sa.password = "sa"
		sa.password_confirmation = "sa"
		sa.save!
		
		faculty = User.new
		faculty.first_name = "faculty"
		faculty.middle_name = "faculty"
		faculty.last_name = "faculty"
		faculty.email = "faculty@faculty.edu"
		faculty.username = "faculty"
		faculty.password = "faculty"
		faculty.password_confirmation = "faculty"
		faculty.save!
		

	#Step 4.5: add Assign Dad to Gaming Club as System Admin
		sys = Assignment.new
		sys.user_id = sys.id
		sys.club_id = x.id
		sys.role_id = sys.id
		sys.active = true
		sys.save!
		
		faculty = Assignment.new
		faculty.user_id = faculty.id
		faculty.club_id = x.id
		faculty.role_id = faculty.id
		faculty.active = true
		faculty.save!
	
		vp = Assignment.new
		vp.user_id = vp.id
		vp.club_id = x.id
		vp.role_id = vp.id
		vp.active = true
		vp.save!
   
		leader = Assignment.new
		leader.user_id = leader.id
		leader.club_id = x.id
		leader.role_id = leader.id
		leader.active = true
		leader.save!
		
		sa = Assignment.new
		sa.user_id = sa.id
		sa.club_id = x.id
		sa.role_id = sa.id
		sa.active = true
		sa.save!
    
	# Step 5.5: Add Account
		acc = Account.new
		acc.year = "2011"
		acc.club_id = x.id
		acc.active = true
		acc.save!
		
	
	# Step 6: add some debitcategories to work with 
    debitcategories = %w[Food Decoration Equipement Other]
    debitcategories.each do |category|
      dc = DebitCategory.new
      dc.category = category
      dc.save!
    end
	
	# Step 8: add some creditcategories to work with 
    creditcategories = %w[Inital Special Other]
    creditcategories.each do |category|
      cc = CreditCategory.new
      cc.category = category
      cc.save!
    end
	
	
	
	   # Step 7: add some debits and assign them to account
    #Debit.populate 100 do |debit|
    #  debit.account_id = Account.all.map{|a| a.id}
    #  debit.reason = Faker::Company.catch_phrase
    #  #debit.number_of_consumers = rand(1) + 2
	#  #debit.name_of_consumers = User.all.map{|u| u.name} 
	#  debit.item_purchased = Faker::Company.catch_phrase
	#  debit.date_purchased = 1.month.ago..2.days.ago
	#  debit.amount = rand(10*10) + 2
	#  debit.debit_category_id = DebitCategory.all.map{|dc| dc.id}
    #  debit.reimbursement_date = 1.months.ago..2.days.ago
    #end 
	
	# Step 9: add some credits and assign them to account
    #Credit.populate 50 do |credit|
    #  credit.account_id = Account.all.map{|a| a.id}
	#  credit.credit_category_id = CreditCategory.all.map{|cc| cc.id}
    #  credit.date = 1.month.ago..2.days.ago
	#  credit.amount = rand(10*10) + 2
    #end 
	
	end
end
