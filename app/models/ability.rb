class Ability
  include CanCan::Ability

  def initialize(user)
    #Define abilities for the passed in user here. For example:
    ## does a user ever have more than one role?? ##
       user ||= User.new # guest user (not logged in)
		if user.is_admin?
			can :manage, :all
		elsif user.is_vp?
			can :create, :account
			can :read, :all
			can :credit, :club
		elsif user.is_affairs?
			can :read, Club do |this_club|
				assignment_clubs = user.assignments.map{|a| a.club_id if a.active}
				assignment_clubs.include? this_club.id
			end
			can :reimburse, Debit do |this_debit|
				assignment_clubs = user.assignments.map{|a| a.club_id if a.active}
				assignment_clubs.include? this_debit.account.club_id
			end
		elsif user.is_leader?
			can :read, Club do |this_club|
				assignment_clubs = user.assignments.map{|a| a.club_id if a.active}
				assignment_clubs.include? this_club.id
			end
			can :create, Debit do |this_debit|
				assignment_clubs = user.assignments.map{|a| a.club if a.active}
				clubs_active_accounts = assignment_clubs.compact.map{|c|
					unless c.current_account.nil?
					c.current_account.id
					end
					}
				clubs_active_accounts.compact.include? this_debit.account.id
			end
			# need to get all the accounts for clubs you are actively assigned to
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
		#else			
			#the treasure/club leader of Student Majlis falls under leader
			# who else would get to here and what should they see
			#can :read, :all
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
  end
end
