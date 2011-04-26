class ClubsController < ApplicationController
	before_filter :login_required
	load_and_authorize_resource
	
	def index
		@clubs = Club.all.paginate :page => params[:page], :per_page => 20
		authorize! :read, Club, :message => "Action Not Authorized"
		unless current_user.is_admin? || current_user.is_director?
			redirect_to root_url
		else
		respond_to do |format|
		  format.html # index.html.erb
		  format.xml  { render :xml => @clubs }
		end
		end
	end


	def show  
		#Scope Definitions
		p "asdF"
		$stdout.flush
		@club = Club.find(params[:id])
		authorize! :read, @club, :message => "Action Not Authorized"
		
		#all accounts for @club
		@inactive_accounts = Account.inactive_for_club(@club).paginate :page => params[:page], :per_page => 5
		#get all assignment for @club
		@active_assignments_for_club = Assignment.active_for_club(@club)#.paginate :page => params[:page], :per_page => 5
		
		unless @club.current_account.nil?
			#all debits for active account of @club
			@account_debits = @club.current_account.debits.paginate :page => params[:page], :per_page => 20
			#all credits for active account of @club
			@account_credits = @club.current_account.credits.paginate :page => params[:page], :per_page => 20
		end
		
		respond_to do |format| p "asdF"
		  format.html # show.html.erb
		  format.xml  { render :xml => @club }
		end
	end

	def new
		@club = Club.new
		authorize! :read, Club, :message => "Action Not Authorized"
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

	def deactivate5
		@club = Club.find(params[:id])
		@club.active = false
		@club.save!(:validate => false)
		redirect_to clubs_path, :notice => "#{@club.name} deactivated."
	end
	 
	def reactivate5
		@club = Club.find(params[:id])
		@club.active = true
		@club.save!(:validate => false)
		redirect_to clubs_path, :notice => "#{@club.name} reactivated."
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
