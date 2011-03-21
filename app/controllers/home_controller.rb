class HomeController < ApplicationController
	layout "application"
	
  def index
	if logged_in?
		unless current_user.is_admin? || current_user.is_VP?
			unless current_user.assignments.nil? || current_user.assignments.empty?
				unless current_user.assignments.count == 1 
					for assignment in current_user.assignments
						if assignment.active
							redirect_to club_path(assignment.club_id)
						end
					end
				else
					redirect_to club_path(current_user.assignments[0].club_id)
				end
			end
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
