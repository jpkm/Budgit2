class HomeController < ApplicationController
	layout "application"
	
	def index
		if logged_in?
			unless current_user.is_admin? || current_user.is_vp?
				unless current_user.assignments.nil? || current_user.assignments.empty?
					if current_user.count_active_assignments == 1 
						redirect_to club_path(current_user.assignments[0].club_id)
					end
				end
			end
		end
	end
	  
	def show
		if logged_in?
			#list of assignments for the user
			@assignment_for_user = Assignment.for_user(current_user).all
		end
	end
	  
	def say_when
		render_text "<p>The time is <b>" + DateTime.now.to_s + "</b></p>"
	end
end
