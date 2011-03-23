class Notifier < ActionMailer::Base
  default :from => 'mezaniah.budgit.373@gmail.com',
          :return_path => 'mezaniah.budgit.373@gmail.com'

  def welcome_email(user)
	@user = user
    mail(:to => @user.email, :subject => "Welcome to Mezaniah!", :cc => "mezaniah.budgit.373@gmail.com")
    end
  end