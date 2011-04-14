class ClubsController < ApplicationController
	before_filter :login_required
	load_and_authorize_resource
	
	def index
		@clubs = Club.all.paginate :page => params[:page], :per_page => 20
		authorize! :read, @clubs, :message => "No no no"
		
		respond_to do |format|
		  format.html # index.html.erb
		  format.xml  { render :xml => @clubs }
		end
	end


	def show  
		#Scope Definitions
		@club = Club.find(params[:id])
		authorize! :read, @club, :message => "No no no"
		#all accounts for @club
		@inactive_accounts = Account.inactive_for_club(@club).paginate :page => params[:page], :per_page => 5
		#get all assignment for @club
		@active_assignments_for_club = Assignment.active_for_club(@club)#.paginate :page => params[:page], :per_page => 5
		
		unless @club.current_account.nil?
			#all debits for active account of @club
			@account_debits = @club.current_account.debits.paginate :page => params[:page], :per_page => 5
			#all credits for active account of @club
			@account_credits = @club.current_account.credits.paginate :page => params[:page], :per_page => 5
			# gets all debits which are unreimbursed for an account
			@debits_unreimbursed = Debit.not_reimbursed_for_account(@club.current_account).paginate :page => params[:page], :per_page => 5
		end
		
		respond_to do |format|
		  format.html # show.html.erb
		  format.xml  { render :xml => @club }
		end
	end

	def new
		@club = Club.new
		authorize! :read, @clubs, :message => "No no no"
		
		respond_to do |format|
		  format.html # new.html.erb
		  format.xml  { render :xml => @club }
		end
	end

	  
	def edit
		@club = Club.find(params[:id])
	end

	def create
		@club = Club.new(params[:club])

		respond_to do |format|
		  if @club.save
			Account.make_account(@club.id)
			format.html { redirect_to(club_path(@club), :notice => 'Club and Account were successfully created.') }
			format.xml  { render :xml => @club, :status => :created, :location => @club }
		  else
			format.html { render :action => "new" }
			format.xml  { render :xml => @club.errors, :status => :unprocessable_entity }
		  end
		end
	end

	def update
		@club = Club.find(params[:id])

		respond_to do |format|
		  if @club.update_attributes(params[:club])
			format.html { redirect_to((@club), :notice => 'Club was successfully updated.') }
			format.xml  { head :ok }
		  else
			format.html { render :action => "edit" }
			format.xml  { render :xml => @club.errors, :status => :unprocessable_entity }
		  end
		end
	end

	  # you can't do this
	def destroy
		@club = Club.find(params[:id])
		@club.destroy

		respond_to do |format|
		  format.html { redirect_to(clubs_url) }
		  format.xml  { head :ok }
		end
	end
end
