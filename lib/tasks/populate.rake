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
		rsys = Role.new
		rsys.name = "System Admin"
		rsys.save!
	  
		rvp = Role.new
		rvp.name = "VP of Finance"
		rvp.save!
	  
		rleader = Role.new
		rleader.name = "Club Leader"
		rleader.save!
	  
		rfaculty = Role.new
		rfaculty.name = "Faculty Advisor"
		rfaculty.save!
	  
		rsa = Role.new
		rsa.name = "Student Affairs"
		rsa.save!
	  
	
	# Step 3.5: add X club
		x = Club.new
		x.name = "X"
		x.save!
    
    # Step 4: add Users
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
		

	#Step 4.5: add Assignments
		asys = Assignment.new
		asys.user_id = sys.id
		asys.club_id = x.id
		asys.role_id = rsys.id
		asys.active = true
		asys.save!
		
		afaculty = Assignment.new
		afaculty.user_id = faculty.id
		afaculty.club_id = x.id
		afaculty.role_id = rfaculty.id
		afaculty.active = true
		afaculty.save!
	
		avp = Assignment.new
		avp.user_id = vp.id
		avp.club_id = x.id
		avp.role_id = rvp.id
		avp.active = true
		avp.save!
   
		aleader = Assignment.new
		aleader.user_id = leader.id
		aleader.club_id = x.id
		aleader.role_id = rleader.id
		aleader.active = true
		aleader.save!
		
		asa = Assignment.new
		asa.user_id = sa.id
		asa.club_id = x.id
		asa.role_id = rsa.id
		asa.active = true
		asa.save!
    
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
