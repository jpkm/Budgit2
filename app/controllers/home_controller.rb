class HomeController < ApplicationController
	layout "application"
	
  def index
	if logged_in?
		unless current_user.is_admin? || current_user.is_VP?
			
			# list of assignments for the user
			#@assignment_for_user = Assignment.for_user(current_user).all
			@assignments_for_user = current_user.assignments
			
			unless @assignments_for_user.nil? 
				@debits_unreimbursed = []
				for assign in @assignments_for_user
					unless assign.club.current_account.nil?
						@deb = assign.club.current_account.unreimbursed
						#@deb = Debit.not_reimbursed_for_account(assign.club.current_account.id)
							for debit in @deb
								@debits_unreimbursed << debit
							end
					end
				end
			
				unless current_user.is_affairs?
					if @assignments_for_user.count == 1
						@club = @assignments_for_user[0]
						redirect_to club_path(@club.club_id)
					end
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
