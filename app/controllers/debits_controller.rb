class DebitsController < ApplicationController
	before_filter :login_required
  # GET /debits
  # GET /debits.xml
  def index
    @debits = Debit.all.paginate :page => params[:page], :per_page => 5
	
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @debits }
    end
  end

  # GET /debits/1
  # GET /debits/1.xml
  def show
    @debit = Debit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @debit }
    end
  end

  # GET /debits/new
  # GET /debits/new.xml
  def new
    @debit = Debit.new
	@debit.account_id =  params[:account]
	
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @debit }
    end
  end

  # GET /debits/1/edit
  def edit
    @debit = Debit.find(params[:id])
  end

  # POST /debits
  # POST /debits.xml
  def create
    @debit = Debit.new(params[:debit])
	#@defect.account_id = params[:account]
    
	respond_to do |format|
      if @debit.save
        format.html { redirect_to(@debit, :notice => 'Debit was successfully created.') }
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
        format.html { redirect_to(@debit, :notice => 'Debit was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @debit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /debits/1
  # DELETE /debits/1.xml
  def destroy
    @debit = Debit.find(params[:id])
    @debit.destroy

    respond_to do |format|
      format.html { redirect_to(debits_url) }
      format.xml  { head :ok }
    end
  end
end
