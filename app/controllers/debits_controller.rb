class DebitsController < ApplicationController
	before_filter :login_required
	layout "application"
 
  def index
	redirect_to root_url
    #@debits = Debit.all.paginate :page => params[:page], :per_page => 5
    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml  { render :xml => @debits }
    #end
  end

 
  def show
    @debit = Debit.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @debit }
    end
  end

  def new
    @debit = Debit.new	
	@debit.account_id = params[:account]
	@debit.reimbursement_date = "null"
	authorize! :create, @debit, :message => "NO!"
    
	respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @debit }
    end
  end

  def edit
    @debit = Debit.find(params[:id])
  end

  def create
    @debit = Debit.new(params[:debit])
	@debit.reimbursement_date = "null"
	authorize! :create, @debit, :message => "NO!"
	
	respond_to do |format|
      if @debit.save 
		Notifier.debit_email(current_user, @debit).deliver
        format.html { redirect_to(club_path(@debit.account.club_id), :notice => 'Debit was successfully created.') }
        format.xml  { render :xml => @debit, :status => :created, :location => @debit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @debit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /debits/1
  # PUT /debits/1.xml
  def update
    @debit = Debit.find(params[:id])
	
    respond_to do |format|
      if @debit.update_attributes(params[:debit])
		format.html { redirect_to(club_path(@debit.account.club_id), :notice => 'Debit reimbursed') }
		#format.html { redirect_to(@debit, :notice => 'Debit was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @debit.errors, :status => :unprocessable_entity }
      end
    end
  end

  
  def destroy
    @debit = Debit.find(params[:id])
    redirect_to(@debit.account.club)
	
	@debit.destroy
  end

  def reimburse
	@debit = Debit.find(params[:id])
	authorize! :reimburse, @debit, :message => "no"
	@debit.reimbursement_date = DateTime.now
	@debit.save!
	Notifier.reimburse_email(current_user, @debit).deliver
	redirect_to(club_path(@debit.account.club_id), :notice => 'Debit Reimbursed.')
  end
  
end



