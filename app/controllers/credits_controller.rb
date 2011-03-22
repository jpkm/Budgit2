class CreditsController < ApplicationController
	before_filter :login_required
	layout "application"
  # GET /credits
  # GET /credits.xml
  def index
	redirect_to root_url
    #@credits = Credit.all
    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml  { render :xml => @credits }
    #end
  end

  # GET /credits/1
  # GET /credits/1.xml
  def show
	redirect_to root_url
    #@credit = Credit.find(params[:id])
    #respond_to do |format|
    #  format.html # show.html.erb
    #  format.xml  { render :xml => @credit }
    #end
  end

  # GET /credits/new
  # GET /credits/new.xml
  def new
    @credit = Credit.new
	@credit.account_id = params[:account]
	@account = Account.find(params[:account])
	@answer = @account.has_inital?
	@credit.date = Date.today
	
	if @answer
		@except = CreditCategory.except_inital
		#@except = []
		#for creditcategory in CreditCategory.all
		#	unless creditcategory.category.eql?("Inital")
		#		@except << creditcategory
		#	end
		#end
	end
	

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @credit }
    end
  end

  # GET /credits/1/edit
  def edit
    @credit = Credit.find(params[:id])
  end

  # POST /credits
  # POST /credits.xml
  def create
    @credit = Credit.new(params[:credit])
	@credit.date = Date.today
	
    respond_to do |format|
      if @credit.save
		format.html { redirect_to(club_path(@credit.account.club_id), :notice => 'Credit was successfully created.') }
        #format.html { redirect_to(@credit, :notice => 'Credit was successfully created.') }
        format.xml  { render :xml => @credit, :status => :created, :location => @credit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @credit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /credits/1
  # PUT /credits/1.xml
  def update
    @credit = Credit.find(params[:id])

    respond_to do |format|
      if @credit.update_attributes(params[:credit])
        format.html { redirect_to(club_path(@credit.account.club_id), :notice =>'Credit was successfully updated.') }
		#format.html { redirect_to(@credit, :notice => 'Credit was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @credit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /credits/1
  # DELETE /credits/1.xml
  def destroy
	@credit = Credit.find(params[:id])
    redirect_to(@credit.account.club)
	@credit.destroy

    #respond_to do |format|
    #  format.html { redirect_to(credits_url) }
    #  format.xml  { head :ok }
    #end
  end
end
