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
		x.name = "Gaming Club"
		x.club_key = "312"
		x.save!
    
		y = Club.new
		y.name = "DSO"
		y.club_key = "123"
		y.save!
	
		z = Club.new
		z.name = "Active Women"
		z.club_key = "124"
		z.save!
		
		j = Club.new
		j.name = "Debate Club"
		j.club_key = "125"
		j.save!
		
		p = Club.new
		p.name = "All Around"
		p.club_key = "126"
		p.save!
	
	
    # Step 4: add Users
		sys = User.new
		sys.first_name = "System"
		sys.middle_name = "Ad"
		sys.last_name = "Min"
		sys.email = "system@admin.edu"
		sys.username = "davestan"
		sys.password = "davestan"
		sys.password_confirmation = "davestan"
		sys.save!
			
		vp = User.new
		vp.first_name = "VP"
		vp.middle_name = "of"
		vp.last_name = "Finance"
		vp.email = "v@p.edu"
		vp.username = "vpfinance"
		vp.password = "vpfinance"
		vp.password_confirmation = "vpfinance"
		vp.save!
		
		#assigned to DSO, Active Women
		leader1 = User.new
		leader1.first_name = "Leader"
		leader1.middle_name = "of"
		leader1.last_name = "Club"
		leader1.email = "leader1@leader.edu"
		leader1.username = "hahmed"
		leader1.password = "hahmed"
		leader1.password_confirmation = "hahmed"
		leader1.save!
	
		#assigned to Debate Club
		leader2 = User.new
		leader2.first_name = "Leader"
		leader2.middle_name = "of"
		leader2.last_name = "Club"
		leader2.email = "leader2@leader.edu"
		leader2.username = "sislam"
		leader2.password = "sislam"
		leader2.password_confirmation = "sislam"
		leader2.save!
		
	
		#assigned to DSO, Debate Club, Active Women
		sa1 = User.new
		sa1.first_name = "Student"
		sa1.middle_name = "Affairs"
		sa1.last_name = "Officer"
		sa1.email = "sa1@sa.edu"
		sa1.username = "jduffy"
		sa1.password = "jduffy"
		sa1.password_confirmation = "jduffy"
		sa1.save!
		
		#assigned to Gaming Club, All Around
		sa2 = User.new
		sa2.first_name = "Student"
		sa2.middle_name = "Affairs"
		sa2.last_name = "Officer"
		sa2.email = "sa2@sa.edu"
		sa2.username = "kdarco"
		sa2.password = "kdarco"
		sa2.password_confirmation = "kdarco"
		sa2.save!
		
		#faculty = User.new
		#faculty.first_name = "Ian"
		#faculty.middle_name = "PhD"
		#faculty.last_name = "Lacey"
		#faculty.email = "faculty@faculty.edu"
		#faculty.username = "faculty"
		#faculty.password = "faculty"
		#faculty.password_confirmation = "faculty"
		#faculty.save!
		

	#Step 4.5: add Assignments
		asys = Assignment.new
		asys.user_id = sys.id
		asys.role_id = rsys.id
		asys.active = true
		asys.save!
		
		#afaculty = Assignment.new
		#afaculty.user_id = faculty.id
		#afaculty.club_id = x.id
		#afaculty.role_id = rfaculty.id
		#afaculty.active = true
		#afaculty.save!
	
		avp = Assignment.new
		avp.user_id = vp.id
		avp.role_id = rvp.id
		avp.active = true
		avp.save!
   
		#DSO
		a1leader = Assignment.new
		a1leader.user_id = leader1.id
		a1leader.club_id = y.id
		a1leader.role_id = rleader.id
		a1leader.active = true
		a1leader.save!
		
		#Active Women
		a2leader = Assignment.new
		a2leader.user_id = leader1.id
		a2leader.club_id = z.id
		a2leader.role_id = rleader.id
		a2leader.active = true
		a2leader.save!
		
		#Debate Club
		b1leader = Assignment.new
		b1leader.user_id = leader2.id
		b1leader.club_id = j.id
		b1leader.role_id = rleader.id
		b1leader.active = true
		b1leader.save!
		
		#kdarco for Gaming Club
		asa = Assignment.new
		asa.user_id = sa2.id
		asa.club_id = x.id
		asa.role_id = rsa.id
		asa.active = true
		asa.save!
		
		#kdarco for All Around
		bsa = Assignment.new
		bsa.user_id = sa2.id
		bsa.club_id = p.id
		bsa.role_id = rsa.id
		bsa.active = true
		bsa.save!
		
		#jduffy for DSO
		csa = Assignment.new
		csa.user_id = sa1.id
		csa.club_id = y.id
		csa.role_id = rsa.id
		csa.active = true
		csa.save!
		
		#jduffy for Debate Club
		esa = Assignment.new
		esa.user_id = sa1.id
		esa.club_id = j.id
		esa.role_id = rsa.id
		esa.active = true
		esa.save!
		
		#jduffy for Active Women
		fsa = Assignment.new
		fsa.user_id = sa1.id
		fsa.club_id = z.id
		fsa.role_id = rsa.id
		fsa.active = true
		fsa.save!
	
	# Step 5.5: Add Account
		acx = Account.new
		acx.date = Time.now
		acx.club_id = x.id
		acx.active = true
		acx.save!
		
		acy = Account.new
		acy.date = Time.now
		acy.club_id = y.id
		acy.active = true
		acy.save!
		
		acz = Account.new
		acz.date = Time.now
		acz.club_id = z.id
		acz.active = true
		acz.save!
	
		acj = Account.new
		acj.date = Time.now
		acj.club_id = j.id
		acj.active = true
		acj.save!
		
		acp = Account.new
		acp.date = Time.now
		acp.club_id = p.id
		acp.active = true
		acp.save!
	
	# Step 6: add some debitcategories to work with 
		df = DebitCategory.new
		df.category = "Food"
		df.active = true
		df.save!
		  
		dd = DebitCategory.new
		dd.category = "Decoration"
		dd.active = true
		dd.save!
		  
		de = DebitCategory.new
		de.category = "Equipement"
		de.active = true
		de.save!
		  
		dt = DebitCategory.new
		dt.category = "Other"
		dt.active = true
		dt.save!
		
	
	# Step 8: add some creditcategories to work with 
		ci = CreditCategory.new
		ci.category = "Initial"
		ci.active = true
		ci.save!
    
		cs = CreditCategory.new
		cs.category = "Special"
		cs.active = true
		cs.save!
	  
		co = CreditCategory.new
		co.category = "Other"
		co.active = true
		co.save!
	
	# Step 9: add some credits and assign them to account
	  c = Credit.new
      c.account_id = acx.id
	  c.credit_category_id = ci.id 
      c.date = Time.now
	  c.amount = 4000
      c.save!
		
	  d = Credit.new
      d.account_id = acy.id
	  d.credit_category_id = ci.id 
      d.date = Time.now
	  d.amount = 4000
      d.save! 
	  
	  d = Credit.new
      d.account_id = acz.id
	  d.credit_category_id = ci.id 
      d.date = Time.now
	  d.amount = 4000
      d.save! 
	  
	  e = Credit.new
      e.account_id = acj.id
	  e.credit_category_id = ci.id 
      e.date = Time.now
	  e.amount = 4000
      e.save! 
	  
	  f = Credit.new
      f.account_id = acp.id
	  f.credit_category_id = ci.id
      f.date = Time.now
	  f.amount = 4000
      f.save! 
	  
	    # Step 7: add some debits and assign them to account
	  # with debit unreimbursed
	  d = Debit.new
      d.account_id = acx.id 
      d.reason = "hunger"
      d.number_of_consumers = 6 
	  d.names_of_consumers = nil 
	  d.item_purchased = "hot dogs"
	  d.date_purchased = Time.now
	  d.amount = 10
	  d.debit_category_id = df.id
      d.reimbursement_date = nil
	  d.save!
	  
	  #with debit reimbursed
	  a = Debit.new
      a.account_id = acx.id 
      a.reason = "hunger"
      a.number_of_consumers = 6 
	  a.names_of_consumers = nil 
	  a.item_purchased = "hot dogs"
	  a.date_purchased = Time.now
	  a.amount = 10
	  a.debit_category_id = df.id
      a.reimbursement_date = Date.new
	  a.save!
	
	  # with debit unreimbursed
	  b = Debit.new
      b.account_id = acy.id 
      b.reason = "hunger"
      b.number_of_consumers = 6 
	  b.names_of_consumers = nil 
	  b.item_purchased = "hot dogs"
	  b.date_purchased = Time.now
	  b.amount = 10
	  b.debit_category_id = df.id
      b.reimbursement_date = nil
	  b.save!
	  
	  #with debit reimbursed
	  c = Debit.new
      c.account_id = acy.id 
      c.reason = "hunger"
      c.number_of_consumers = 6 
	  c.names_of_consumers = nil 
	  c.item_purchased = "hot dogs"
	  c.date_purchased = Time.now
	  c.amount = 10
	  c.debit_category_id = df.id
      c.reimbursement_date = Date.new
	  c.save!
	  
	  # with debit unreimbursed
	  e = Debit.new
      e.account_id = acz.id 
      e.reason = "hunger"
      e.number_of_consumers = 6 
	  e.names_of_consumers = nil 
	  e.item_purchased = "hot dogs"
	  e.date_purchased = Time.now
	  e.amount = 10
	  e.debit_category_id = df.id
      e.reimbursement_date = nil
	  e.save!
	  
	  #with debit reimbursed
	  f = Debit.new
      f.account_id = acz.id 
      f.reason = "hunger"
      f.number_of_consumers = 6 
	  f.names_of_consumers = nil 
	  f.item_purchased = "hot dogs"
	  f.date_purchased = Time.now
	  f.amount = 10
	  f.debit_category_id = df.id
      f.reimbursement_date = Date.new
	  f.save!
	  
	  # with debit unreimbursed
	  g = Debit.new
      g.account_id = acj.id 
      g.reason = "hunger"
      g.number_of_consumers = 6 
	  g.names_of_consumers = nil 
	  g.item_purchased = "hot dogs"
	  g.date_purchased = Time.now
	  g.amount = 10
	  g.debit_category_id = df.id
      g.reimbursement_date = nil
	  g.save!
	  
	  #with debit reimbursed
	  h = Debit.new
      h.account_id = acj.id 
      h.reason = "hunger"
      h.number_of_consumers = 6 
	  h.names_of_consumers = nil 
	  h.item_purchased = "hot dogs"
	  h.date_purchased = Time.now
	  h.amount = 10
	  h.debit_category_id = df.id
      h.reimbursement_date = Date.new
	  h.save!
	  
	  # with debit unreimbursed
	  i = Debit.new
      i.account_id = acp.id 
      i.reason = "hunger"
      i.number_of_consumers = 6 
	  i.names_of_consumers = nil 
	  i.item_purchased = "hot dogs"
	  i.date_purchased = Time.now
	  i.amount = 10
	  i.debit_category_id = df.id
      i.reimbursement_date = nil
	  i.save!
	  
	  #with debit reimbursed
	  j = Debit.new
      j.account_id = acp.id 
      j.reason = "hunger"
      j.number_of_consumers = 6 
	  j.names_of_consumers = nil 
	  j.item_purchased = "hot dogs"
	  j.date_purchased = Time.now
	  j.amount = 10
	  j.debit_category_id = df.id
      j.reimbursement_date = Date.new
	  j.save!
	  
end
	
end
