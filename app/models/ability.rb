class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
		if user.is_admin?
			can :manage, :all
			cannot :edit, Credit do |this_credit|
				!this_credit.account.active
			end
			cannot :manage, Debit do |this_debit|
				!this_debit.account.active
			end
			cannot :manage, Debit do |this_debit|
				this_debit.status.eql?("reimbursed")
			end
			can :create, Debit
			can :create, Credit
		elsif user.is_director?
			can :manage, [Assignment, User, Club, DebitCategory, CreditCategory, Account]
			can :read, [Debit,Credit]
			can :create, Credit do |this_credit|
				this_credit.account.active
			end		
			can :process_me, Debit do |this_debit|
				this_debit.account.active && this_debit.status.strip.downcase.eql?("processing")
			end
		elsif user.is_vp?
			can :create, :account
			can :read, :all
			can :credit, :club
			can [:update, :edit, :create], Credit do |this_credit|
				this_credit.account.active
			end
		elsif user.is_affairs?
			can :read, Club do |this_club|
				assignment_clubs = user.assignments.map{|a| a.club_id if a.active}
				assignment_clubs.include? this_club.id
			end
			can :reimburse, Debit do |this_debit|
				assignment_clubs = user.assignments.map{|a| a.club_id if a.active}
				(assignment_clubs.include? this_debit.account.club_id) && this_debit.account.active && this_debit.status.strip.downcase.eql?("ready")
			end
			can :ready, Debit do |this_debit|
				assignment_clubs = user.assignments.map{|a| a.club_id if a.active}
			    (assignment_clubs.include? this_debit.account.club_id) && this_debit.account.active && this_debit.status.strip.downcase.eql?("processing")
			end
			can :claim, Debit do |this_debit|
				assignment_clubs = user.assignments.map{|a| a.club_id if a.active}
			    (assignment_clubs.include? this_debit.account.club_id) && this_debit.account.active && this_debit.status.strip.downcase.eql?("unclaimed")
			end
		elsif user.is_leader?
			can :read, Club do |this_club|
				assignment_clubs = user.assignments.map{|a| a.club_id}
				assignment_clubs.include? this_club.id
			end
			can :create, Debit do |this_debit|
				assignment_clubs = user.assignments.map{|a| a.club}
				clubs_active_accounts = assignment_clubs.compact.map{|c|
					unless c.current_account.nil?
					c.current_account.id
					end
					}
				clubs_active_accounts.compact.include? this_debit.account.id
			end
			can :read, Account do |this_account|
				assignment_clubs = user.assignments.map{|a| a.club if a.active}
				accounts = []
				for club in assignment_clubs.compact
					for account in club.accounts
						accounts << account
					end
				end
				accounts.include? this_account
			end
		elsif user.is_faculty?
			can :read, Club do |this_club|
				assignment_clubs = user.assignments.map{|a| a.club_id}
				assignment_clubs.include? this_club.id
			end
			can :read, Account do |this_account|
				assignment_clubs = user.assignments.map{|a| a.club if a.active}
				accounts = []
				for club in assignment_clubs.compact
					for account in club.accounts
						accounts << account
					end
				end
				accounts.include? this_account
			end
		end
	end
end		
	
			
			
    
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  
