class HomeController < ApplicationController
	layout "application"
	
  def index
	if logged_in?
		# list of assignments for the user
		@assignment_for_user = Assignment.for_user(current_user).all

		
		@debits_unreimbursed = []
		p @debits_unreimbursed
		p @assignment_for_user
		for assign in @assignment_for_user
			@deb = Debit.not_reimbursed_for_account(assign.club.current_account.id)
			p @deb
			for debit in @deb
				p @deb
				@debits_unreimbursed << debit
			end
		end
		
		
		unless current_user.is_admin? || current_user.is_VP? || current_user.is_affairs?
			if @assignment_for_user.count == 1
				#p @assignment_for_user[0]
				@club = @assignment_for_user[0]
				#p @club.club_id
				redirect_to club_path(@club.club_id)
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
