namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    # Need two gems to make this work: faker & populator
    # Docs at: http://populator.rubyforge.org/
    require 'populator'
    
    # Step 1: clear any old data in the db
    [Assignment, Debit, Credit, DebitCategory, CreditCategory, User, Role, Club, Account].each(&:delete_all)
    
	# Step 2: add some Role to work with
		rsys = Role.new
		rsys.name = "System Admin"
		rsys.save!
		
		rdsa = Role.new
		rdsa.name = "Director"
		rdsa.save!
	  
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
		x.active = true
		x.save!
    
		y = Club.new
		y.name = "DSO"
		y.club_key = "123"
		y.active = true
		y.save!
	
		z = Club.new
		z.name = "Active Women"
		z.club_key = "124"
		z.active = true
		z.save!
		
		j = Club.new
		j.name = "Debate Club"
		j.club_key = "125"
		j.active = true
		j.save!
		
		p = Club.new
		p.name = "All Around"
		p.club_key = "126"
		p.active = true
		p.save!
	
	
    # Step 4: add Users
		
		sys = User.new
		sys.email = "sysa@qatar.cmu.edu"
		sys.first_name = "Larry"
		sys.last_name = "Heimann"
		sys.username = "system"
		sys.password = "system"
		sys.password_confirmation = "system"
		sys.save!
		
		dsa = User.new
		dsa.email = "davesta@qatar.cmu.edu"
		dsa.first_name = "Dave"
		dsa.last_name = "Stanfield"
		dsa.username = "davestan"
		dsa.password = "davestan"
		dsa.password_confirmation = "davestan"
		dsa.save!
			
		vp = User.new
		vp.email = "mmdaule@qatar.cmu.edu"
		vp.first_name = "Muhammad"
		vp.last_name = "Dauleh"
		vp.username = "mmdauleh"
		vp.password = "mmdauleh"
		vp.password_confirmation = "mmdauleh"
		vp.save!
		
		#assigned to DSO, Active Women
		leader1 = User.new
		leader1.email = "hahme@qatar.cmu.edu"
		leader1.first_name = "Hira"
		leader1.last_name = "Ahmed"
		leader1.username = "hahmed"
		leader1.password = "hahmed"
		leader1.password_confirmation = "hahmed"
		leader1.save!
	
		#assigned to Debate Club
		leader2 = User.new
		leader2.email = "leader2@leader.edu"
		leader2.first_name = "Samira"
		leader2.last_name = "Islam"
		leader2.username = "sislam"
		leader2.password = "sislam"
		leader2.password_confirmation = "sislam"
		leader2.save!
		
		leader3 = User.new
		leader3.email = "mabuhol@qatar.cmu.edu"
		leader3.first_name = "Muna"
		leader3.last_name = "Abuholayqa"
		leader3.username = "mabuhola"
		leader3.password = "mabuhola"
		leader3.password_confirmation = "mabuhola"
		leader3.save!
	
		#assigned to DSO, Debate Club, Active Women
		sa1 = User.new
		sa1.email = "jaduff@qatar.cmu.edu"
		sa1.first_name = "Jill"
		sa1.last_name = "Duffy"
		sa1.username = "jaduffy"
		sa1.password = "jaduffy"
		sa1.password_confirmation = "jaduffy"
		sa1.save!
		
		#assigned to Gaming Club, All Around
		sa2 = User.new
		sa2.email = "kdarc@qatar.cmu.edu"
		sa2.first_name = "Kevin"
		sa2.last_name = "Darco"
		sa2.username = "kdarco"
		sa2.password = "kdarco"
		sa2.password_confirmation = "kdarco"
		sa2.save!
		
		faculty = User.new
		faculty.email = "faculty@faculty.edu"
		faculty.first_name = "Dan"
		faculty.last_name = "Phelps"
		faculty.username = "dphelps"
		faculty.password = "dphelps"
		faculty.password_confirmation = "dphelps"
		faculty.save!
		

	#Step 4.5: add Assignments
		asys = Assignment.new
		asys.user_id = sys.id
		asys.role_id = rsys.id
		asys.active = true
		asys.save!
		
		adsa = Assignment.new
		adsa.user_id = dsa.id
		adsa.role_id = rdsa.id
		adsa.active = true
		adsa.save!
		
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
		de.category = "Equipment"
		de.active = true
		de.save!
    
		dp = DebitCategory.new
		dp.category = "Printing"
		dp.active = true
		dp.save!
		  
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
      c.date = Date.today
	  c.amount = 4000
      c.save!
		
	  d = Credit.new
      d.account_id = acy.id
	  d.credit_category_id = ci.id 
      d.date = Date.today
	  d.amount = 9500
      d.save! 
	  
	  d = Credit.new
      d.account_id = acz.id
	  d.credit_category_id = ci.id 
      d.date = Date.today
	  d.amount = 3000
      d.save! 
	  
	  e = Credit.new
      e.account_id = acj.id
	  e.credit_category_id = ci.id 
      e.date = Date.today
	  e.amount = 7000
      e.save! 
	  
	  f = Credit.new
      f.account_id = acp.id
	  f.credit_category_id = ci.id
      f.date = Date.today
	  f.amount = 4500
      f.save! 
	  
	    # Step 7: add some debits and assign them to account
	  # with debit unreimbursed (unclaimed)
	  du = Debit.new
      du.account_id = acx.id 
      du.reason = "Gaming Night"
	  du.vendor = "Yellow Cab"
      du.number_of_consumers = 30 
	  du.names_of_consumers = nil 
	  du.item_purchased = "5 large Pizzas"
	  du.date_purchased = Date.today
	  du.amount = 240
	  du.debit_category_id = df.id
      du.reimbursement_date = nil
	  du.status = "unclaimed"
	  du.save!
	  
	  # with debit unreimbursed (processing)
	  dp = Debit.new
      dp.account_id = acx.id 
      dp.reason = "New games"
	  dp.vendor = "Zen Gaming"
      dp.number_of_consumers = 6 
	  dp.names_of_consumers = nil 
	  dp.item_purchased = "Crysis Core game DVD"
	  dp.date_purchased = Date.today
	  dp.amount = 230
	  dp.debit_category_id = de.id
      dp.reimbursement_date = nil
	  dp.status = "processing"
	  dp.save!
	  
	  # with debit unreimbursed (funds ready)
	  da = Debit.new
      da.account_id = acx.id 
      da.reason = "Gaming Night"
	  da.vendor = "Carrefour"
      da.number_of_consumers = 30 
	  da.names_of_consumers = nil 
	  da.item_purchased = "40 cans of Soda"
	  da.date_purchased = Date.today
	  da.amount = 40
	  da.debit_category_id = df.id
      da.reimbursement_date = nil
	  da.status = "ready"
	  da.save!
	  
	  #with debit reimbursed
	  a = Debit.new
      a.account_id = acx.id 
      a.reason = "Exec meeting"
      a.vendor = "Hala Istanbul"
	  a.number_of_consumers = 6 
	  a.names_of_consumers = nil 
	  a.item_purchased = "Shawarmas"
	  a.date_purchased = Date.today
	  a.amount = 40
	  a.debit_category_id = df.id
      a.reimbursement_date = Date.today
	  a.status = "reimbursed"
	  a.save!
	###########################################
	  # with debit unreimbursed (unclaimed)
	  b = Debit.new
      b.account_id = acy.id 
      b.reason = "Informational Session for TEDxCMUQatar"
	  b.vendor = "Take Away"
      b.number_of_consumers = 15 
	  b.names_of_consumers = nil 
	  b.item_purchased = "Fatayers"
	  b.date_purchased = Date.today
	  b.amount = 100
	  b.debit_category_id = df.id
      b.reimbursement_date = nil
	  b.status = "unclaimed"
	  b.save!
	  
	  # with debit unreimbursed (processing)
	  d = Debit.new
      d.account_id = acy.id 
      d.reason = "Posters for publicity of TEDxCMUQatar"
	  d.vendor = "Printec"
      d.number_of_consumers = 6
	  d.names_of_consumers = nil 
	  d.item_purchased = "4 large Posters"
	  d.date_purchased = Date.today
	  d.amount = 160
	  d.debit_category_id = dp.id
      d.reimbursement_date = nil
	  d.status = "processing"
	  d.save!
	  
	  # with debit unreimbursed (funds ready)
	  d5 = Debit.new
      d5.account_id = acy.id 
      d5.reason = "Business Cards for Exec Board"
	  d5.vendor = "Printec"
      d5.number_of_consumers = 6 
	  d5.names_of_consumers = nil 
	  d5.item_purchased = "Business Cards"
	  d5.date_purchased = Date.today
	  d5.amount = 230
	  d5.debit_category_id = dp.id
      d5.reimbursement_date = nil
	  d5.status = "ready"
	  d5.save!
	  
	  #with debit reimbursed
	  c = Debit.new
      c.account_id = acy.id 
      c.reason = "Appreciation dinner"
      c.vendor = "Fauchon"
	  c.number_of_consumers = 50 
	  c.names_of_consumers = nil 
	  c.item_purchased = "Catering for 50 people"
	  c.date_purchased = Date.today
	  c.amount = 1200
	  c.debit_category_id = df.id
      c.reimbursement_date = Date.today
	  c.status = "reimbursed"
	  c.save!
	####################################
	  # with debit unreimbursed(unclaimed)
	  e = Debit.new
      e.account_id = acz.id 
      e.reason = "Selling for pink day"
      e.vendor = "Home Center"
	  e.number_of_consumers = 6 
	  e.names_of_consumers = nil 
	  e.item_purchased = "Pink Cusions"
	  e.date_purchased = Date.today
	  e.amount = 100
	  e.debit_category_id = de.id
      e.reimbursement_date = nil
	  e.status = "unclaimed"
	  e.save!
	  
	  #with debit reimbursed(reimbursed)
	  f = Debit.new
      f.account_id = acz.id 
      f.reason = "Pink Day fundraiser"
      f.vendor = "Gulf Greetings (Hallmark)"
	  f.number_of_consumers = 6 
	  f.names_of_consumers = nil 
	  f.item_purchased = "Pink ribbons"
	  f.date_purchased = Date.today
	  f.amount = 25
	  f.debit_category_id = de.id
      f.reimbursement_date = Date.today
	  f.status = "reimbursed"
	  f.save!
	  
	  # with debit unreimbursed (funds ready)
	  d7 = Debit.new
      d7.account_id = acz.id 
      d7.reason = "to show support for Pink Day"
	  d7.vendor = "Printec"
      d7.number_of_consumers = 6 
	  d7.names_of_consumers = nil 
	  d7.item_purchased = "40 Pink shirts"
	  d7.date_purchased = Date.today
	  d7.amount = 500
	  d7.debit_category_id = de.id
      d7.reimbursement_date = nil
	  d7.status = "ready"
	  d7.save!
	  
	  
	  # with debit unreimbursed(processing)
	  g = Debit.new
      g.account_id = acz.id 
      g.reason = "Pink Day fundraiser"
      g.vendor = "Tasmim"
	  g.number_of_consumers = 30 
	  g.names_of_consumers = nil 
	  g.item_purchased = "40 cupcakes"
	  g.date_purchased = Date.today
	  g.amount = 200
	  g.debit_category_id = df.id
      g.reimbursement_date = nil
	  g.status = "processing"
	  g.save!
	##################################
	  #with debit reimbursed(reimbursed)
	  h = Debit.new
      h.account_id = acp.id 
      h.reason = "For next year's Tartan Carnival Fair"
      h.vendor = "Sharpie"
	  h.number_of_consumers = 6 
	  h.names_of_consumers = nil 
	  h.item_purchased = "Markers"
	  h.date_purchased = Date.today
	  h.amount = 249
	  h.debit_category_id = de.id
      h.reimbursement_date = Date.today
	  h.status = "reimbursed"
	  h.save!
	  
	  # with debit unreimbursed(processing)
	  i = Debit.new
      i.account_id = acp.id 
      i.reason = "Bi-monthly newspaper"
      i.vendor = "Printec"
	  i.number_of_consumers = 6 
	  i.names_of_consumers = nil 
	  i.item_purchased = "Newspapers Vol. 26"
	  i.date_purchased = Date.today
	  i.amount = 500
	  i.debit_category_id = dp.id
      i.reimbursement_date = nil
	  i.status = "processing"
	  i.save!
	  
	  # with debit unreimbursed (funds ready)
	  d9 = Debit.new
      d9.account_id = acp.id 
      d9.reason = "Celebration"
	  d9.vendor = "Pizza Hut"
      d9.number_of_consumers = 20 
	  d9.names_of_consumers = nil 
	  d9.item_purchased = "4 medium Pizzas"
	  d9.date_purchased = Date.today
	  d9.amount = 240
	  d9.debit_category_id = df.id
      d9.reimbursement_date = nil
	  d9.status = "ready"
	  d9.save!
	  
	  #with debit reimbursed (unclaimed)
	  j = Debit.new
      j.account_id = acp.id 
      j.reason = "Celebration"
      j.vendor = "Carrefour"
	  j.number_of_consumers = 20 
	  j.names_of_consumers = nil 
	  j.item_purchased = "30 cans of Soda"
	  j.date_purchased = Time.now
	  j.amount = 30
	  j.debit_category_id = df.id
      j.reimbursement_date = nil
	  j.status = "unclaimed"
	  j.save!
	  
end
end
