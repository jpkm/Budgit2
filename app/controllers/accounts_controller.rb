class AccountsController < ApplicationController
	 before_filter :login_required
	 layout "application"
  # GET /accounts
  # GET /accounts.xml
  def index
	@accounts = Account.all
	authorize! :read, @accounts, :message => "no"
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @accounts }
    end
  end

  # GET /accounts/1
  # GET /accounts/1.xml
  def show
	@account = Account.find(params[:id])
	authorize! :read, @account, :message => "no"
	
	# all debits for active account of @club
	@account_debits = @account.debits.paginate :page => params[:page], :per_page => 5
	# all credits for active account of @club
	@account_credits = @account.credits.paginate :page => params[:page], :per_page => 5
		
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @account }
    end
  end

  # GET /accounts/new
  # GET /accounts/new.xml
  def new
    @account = Account.new
	@account.club_id = params[:club]
	@account.date = Time.new 
	@account.active = true
	
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @account }
    end
  end

  #time.month
  # count starts when new account is made
  # that account is active for 8months then is deactivated
  
  
  # GET /accounts/1/edit
  def edit
    @account = Account.find(params[:id])
  end

  # POST /accounts
  # POST /accounts.xml
  def create
    @account = Account.new(params[:account])
	@account.active = true

    respond_to do |format|
      if @account.save
        format.html { redirect_to(club_path(@account.club_id), :notice => 'Account was successfully created.') }
		#format.html { redirect_to(@account, :notice => 'Account was successfully created.') }
        format.xml  { render :xml => @account, :status => :created, :location => @account }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /accounts/1
  # PUT /accounts/1.xml
  def update
    @account = Account.find(params[:id])

    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to(@account, :notice => 'Account was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.xml
  def destroy
    @account = Account.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to(accounts_url) }
      format.xml  { head :ok }
    end
  end
  
  def deactivate1
  	@account = Account.find(params[:id])
	@account.active = false
	@account.save!
	
	redirect_to(club_path(@account.club_id), :notice => 'Account deactivated.')
  end
  
end
