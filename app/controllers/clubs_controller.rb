class ClubsController < ApplicationController
	before_filter :login_required
	#layout "application"
	
  # GET /clubs
  # GET /clubs.xml
  def index
    @clubs = Club.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clubs }
    end
  end

  # GET /clubs/1
  # GET /clubs/1.xml
  def show  
	# Named Scope Definitions
    @club = Club.find(params[:id])
	# all accounts for @club
	@inactive_accounts = Account.inactive_for_club(@club).paginate :page => params[:page], :per_page => 5
	# all debits for active account of @club
	@account_debits = Debit.for_account(@club.current_account).paginate :page => params[:page], :per_page => 5
	# all credits for active account of @club
	@account_credits = Credit.for_account(@club.current_account).paginate :page => params[:page], :per_page => 5
	# gets all debits which are unreimbursed for an account
	@debits_unreimbursed = Debit.not_reimbursed_for_account(@club.current_account).paginate :page => params[:page], :per_page => 5
	# git all assignment for @club
	@assignments_for_club = Assignment.for_club(@club) #.paginate :page => params[:page], :per_page => 5
	# get initial credit for active account of @club
	#@initial_credit = Credit.initial_for_account(@club.current_account)
	
	unless @club.current_account.nil?
	# calculates Balance of account for @club
		@credits_amount = 0
		@debits_amount = 0

		for credit in Credit.for_account(@club.current_account.id)
			@credits_amount = @credits_amount + credit.amount
		end
	
		for debit in Debit.for_account(@club.current_account.id)
			@debits_amount = @debits_amount + debit.amount
		end
	
		@balance = 0 + 	@credits_amount - @debits_amount
	end
	################################################
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @club }
    end
  end

  # GET /clubs/new
  # GET /clubs/new.xml
  def new
    @club = Club.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @club }
    end
  end

  # GET /clubs/1/edit
  def edit
    @club = Club.find(params[:id])
  end

  # POST /clubs
  # POST /clubs.xml
  def create
    @club = Club.new(params[:club])

    respond_to do |format|
      if @club.save
        format.html { redirect_to(new_account_path(:club => @club), :notice => 'Club was successfully created.') }
        format.xml  { render :xml => @club, :status => :created, :location => @club }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @club.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /clubs/1
  # PUT /clubs/1.xml
  def update
    @club = Club.find(params[:id])

    respond_to do |format|
      if @club.update_attributes(params[:club])
        format.html { redirect_to(@club, :notice => 'Club was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @club.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /clubs/1
  # DELETE /clubs/1.xml
  def destroy
    @club = Club.find(params[:id])
    @club.destroy

    respond_to do |format|
      format.html { redirect_to(clubs_url) }
      format.xml  { head :ok }
    end
  end
end
