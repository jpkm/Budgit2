class HomeController < ApplicationController
	layout "application"
	
  def index
	#@user = current_user
	if logged_in?
		# list of assignments for the user
		@assignment_for_user = Assignment.for_user(current_user).all
	end
  end
  
  def show
	if logged_in?
		# list of assignments for the user
		@assignment_for_user = Assignment.for_user(current_user).all
	
	end
  end

end
