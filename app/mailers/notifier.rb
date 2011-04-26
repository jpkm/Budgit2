class Notifier < ActionMailer::Base
  default :from => 'mezaniah.budgit.373@gmail.com',
			:return_path => 'mezaniah.budgit.373@gmail.com',
			:cc => 'mezaniah.budgit.373@gmail.com'

	#takes a user and send them an email with their login information
	  def welcome_email(user)
		@user = user
		mail(:to => @user.email, :subject => "Welcome to Mezaniah!")
	  end
	  
	  #takes a user and debit and sends an email to user 
	  def debit_email(user, debit)
		unless user.nil? || debit.nil?
			@user = user
			@debit = debit
			mail(:to => @user.email, :subject => "Mezaniah Debit Recieved Information")
		end
	  end
	  
	  #takes a user and debit and sends an email to the club leader
	  def ready_email(user, debit)
		  unless user.nil? || debit.nil?
			@user = user
			@debit = debit
			mail(:to => @user.email, :subject => "Mezaniah Debit Ready Information")
		end
	  end
	  
	  #takes user and debit and sends an email to user sayin it has been reimbursed
		def reimburse_email(user, debit)
			@user = user
			@debit = debit
			mail(:to => @user.email, :subject => "Mezaniah Debit Reimbursement Information")
		end
	  
		def claimed_email(user, debit)
			@user = user
			@debit = debit
			mail(:to => @user.email, :subject => "Mezaniah Debit Claimed Information")
		end
	end