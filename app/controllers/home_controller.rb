class HomeController < ApplicationController
	layout "application"
	
  def index
	if logged_in?
		# list of assignments for the user
		@assignment_for_user = Assignment.for_user(current_user).all

		if @assignment_for_user.count == 1
			p @assignment_for_user[0]
			@club = @assignment_for_user[0]
		end
	end
  end
  
  def show
	if logged_in?
		# list of assignments for the user
		@assignment_for_user = Assignment.for_user(current_user).all
	
	end
  end

end
