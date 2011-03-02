class CreditCategoriesController < ApplicationController
	before_filter :login_required
  # GET /credit_categories
  # GET /credit_categories.xml
  def index
    @credit_categories = CreditCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @credit_categories }
    end
  end

  # GET /credit_categories/1
  # GET /credit_categories/1.xml
  def show
    @credit_category = CreditCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @credit_category }
    end
  end

  # GET /credit_categories/new
  # GET /credit_categories/new.xml
  def new
    @credit_category = CreditCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @credit_category }
    end
  end

  # GET /credit_categories/1/edit
  def edit
    @credit_category = CreditCategory.find(params[:id])
  end

  # POST /credit_categories
  # POST /credit_categories.xml
  def create
    @credit_category = CreditCategory.new(params[:credit_category])

    respond_to do |format|
      if @credit_category.save
        #format.html { redirect_to(@credit_category, :notice => 'Credit category was successfully created.') }
        format.html { redirect_to root_url, :notice => 'Credit category was successfully created.'}
		format.xml  { render :xml => @credit_category, :status => :created, :location => @credit_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @credit_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /credit_categories/1
  # PUT /credit_categories/1.xml
  def update
    @credit_category = CreditCategory.find(params[:id])

    respond_to do |format|
      if @credit_category.update_attributes(params[:credit_category])
        format.html { redirect_to(@credit_category, :notice => 'Credit category was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @credit_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /credit_categories/1
  # DELETE /credit_categories/1.xml
  def destroy
    @credit_category = CreditCategory.find(params[:id])
    @credit_category.destroy

    respond_to do |format|
      format.html { redirect_to(credit_categories_url) }
      format.xml  { head :ok }
    end
  end
end
