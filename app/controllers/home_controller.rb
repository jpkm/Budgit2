class HomeController < ApplicationController
	layout "application"
	
	def index
		if logged_in?
			unless current_user.is_admin? || current_user.is_vp? || current_user.is_director?
				unless current_user.assignments.nil? || current_user.assignments.empty?
					if current_user.count_active_assignments == 1 
						redirect_to club_path(current_user.assignments[0].club_id)
					end
				end
			end
			if current_user.is_affairs?
				@unclaimed_debits = Debit.get_unclaimed(current_user.get_accounts).paginate :page => params[:page], :per_page => 10
				@processing_debits = Debit.get_processing(current_user.get_accounts).paginate :page => params[:page], :per_page => 10
				@ready_debits = Debit.get_ready(current_user.get_accounts).paginate :page => params[:page], :per_page => 10
			elsif current_user.is_director?
				@under_250 = Club.get_all_under_250
				@over_250 = Club.get_all_over_250
				if @over_250.nil? || @over_250.empty? && @under_250.nil? || @under_250.empty?
					redirect_to clubs_path()
				end
			elsif current_user.is_admin?
				redirect_to clubs_path()
			end
		end
	end
	
	def show
		if logged_in?
			#list of assignments for the user
			@assignment_for_user = Assignment.for_user(current_user).all
		end
	end
	 
end
