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
    
    # Step 2: add some Role to work with (small set for now...)
    roles = %w[Faculty Student_Affairs System_Admin Club_Leader VP_of_Finance]
    roles.sort.each do |source|
      r = Source.new
      r.name = source
      r.save!
    end
    
    # Step 3: add some clubs to work with (just six for now)
    clubs = %w[BookManager ChoreTracker Proverbs Arbeit Creamery Friends]
    clubs.each do |club|
      c = Club.new
      c.name = club
      c.save!
    end
    
    # Step 4: add Prof. H as a faculty member
    #u = User.new
    #u.first_name = "Professor"
	#u.middle_name = "Larry"
    #u.last_name = "Heimann"
    #u.email = "profh@cmu.edu"
    #u.username = "profh"
    #u.password = "star_tr3k"
    #u.password_confirmation = "star_tr3k"
    #u.active = true
    #u.assignment = "faculty" #u.is_faculty = true #
    #u.save!
    
    # Step 4: add 20 users to the system and assign
    User.populate 20 do |user|
      user.first_name = Faker::Name.first_name
	  user.middle_name = Faker::Name.middle_name
      user.last_name = Faker::Name.last_name
      user.email = Faker::Internet.email
      user.username = "#{user.first_name}_#{user.last_name}"
      user.crypted_password = rand(10**10).to_s.rjust(10,'0')
      user.active = true
      user.role = %w["faculty", "advisor", "club leader", "maglis"] #user.is_faculty = false
      user.created_at = Time.now
      user.updated_at = Time.now
      
      # Step 4A: assign 1 to 3 projects for each student
      Assignment.populate 1 do |assignment|
        assignment.user_id = user.id
        assignment.club_id = Club.all.map{|c| c.id}
		assignment.role_id = Role.all.map{|r| r.id}
      end  
    end
    
    # Step 5: add some debits and assign them to account
    Debit.populate 100 do |debit|
      debit.account_id = Account.all.map{|a| a.id}
      debit.reason = Faker::Company.catch_phrase
      debit.number_of_consumers = rand(1) + 2
	  debit.name_of_consumers = User.all.map{|u| u.name} 
	  debit.item_purchased = Faker::Company.catch_phrase
	  debit.date_purchased = 1.month.ago..2.days.ago
	  reimbursed = rand(4) + 2
      debit.reimbursement_date = reimbursement.months.from_now
    end  
  end
end
