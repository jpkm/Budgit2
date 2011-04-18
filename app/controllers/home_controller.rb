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
	##When we include DirofStAf processing will need to be changed to mean what it should mean
			@unclaimed_debits = Debit.get_unclaimed(current_user.get_accounts).paginate :page => params[:page], :per_page => 5
			@processing_debits = Debit.get_processing(current_user.get_accounts).paginate :page => params[:page], :per_page => 5
			@ready_debits = Debit.get_ready(current_user.get_accounts).paginate :page => params[:page], :per_page => 5
		end
	end
	  
	def show
		if logged_in?
			#list of assignments for the user
			@assignment_for_user = Assignment.for_user(current_user).all
		end
	end
	 
end
