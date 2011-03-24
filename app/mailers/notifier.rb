class Notifier < ActionMailer::Base
  default :from => 'mezaniah.budgit.373@gmail.com',
			:return_path => 'mezaniah.budgit.373@gmail.com',
			#:cc => 'mezaniah.budgit.373@gmail.com'
			:cc => 'zfh@qatar.cmu.edu'
			

	  def welcome_email(user)
		@user = user
		mail(:to => @user.email, :subject => "Welcome to Mezaniah!")
	  end
	  
	  #takes in user na debit 
	  def debit_email(user, debit)
		@user = user
		@debit = debit
		mail(:to => @user.email, :subject => "Mezaniah Debit Information")
	  end
	  
	  def reimburse_email(user, debit)
		@user = user
		@debit = debit
		mail(:to => @user.email, :subject => "Mezaniah Reimbursement Information")
	  end
  
  end