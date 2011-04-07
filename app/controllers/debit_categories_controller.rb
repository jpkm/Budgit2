class DebitCategoriesController < ApplicationController
	before_filter :login_required 
	layout "application"
	load_and_authorize_resource
	
  def index
	@debit_categories = DebitCategory.all.paginate :page => params[:page], :per_page => 20

	respond_to do |format|
	  format.html # index.html.erb
	  format.xml  { render :xml => @debit_categories }
	end
  end

  def show
	@debit_category = DebitCategory.find(params[:id])

	respond_to do |format|
	  format.html # show.html.erb
	  format.xml  { render :xml => @debit_category }
	end
  end

  def new
	@debit_category = DebitCategory.new
	@debit_category.active = true

	respond_to do |format|
	  format.html # new.html.erb
	  format.xml  { render :xml => @debit_category }
	end
  end

	def edit
		@debit_category = DebitCategory.find(params[:id])
	end

  def create
    @debit_category = DebitCategory.new(params[:debit_category])

    respond_to do |format|
      if @debit_category.save
        format.html { redirect_to root_url, :notice => 'Debit category was successfully created.'}
		format.xml  { render :xml => @debit_category, :status => :created, :location => @debit_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @debit_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @debit_category = DebitCategory.find(params[:id])

    respond_to do |format|
      if @debit_category.update_attributes(params[:debit_category])
        format.html { redirect_to(@debit_category, :notice => 'Debit category was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @debit_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @debit_category = DebitCategory.find(params[:id])
    @debit_category.destroy

    respond_to do |format|
      format.html { redirect_to(debit_categories_url) }
      format.xml  { head :ok }
    end
  end
  
   def deactivate4
  	@debit_category = DebitCategory.find(params[:id])
	@debit_category.active = false
	@debit_category.save!(:validate => false)
	
	redirect_to(debit_categories_path, :notice => 'Debit Category Deactivated.')
  end
  
  def reactivate4
  	@debit_category = DebitCategory.find(params[:id])
	@debit_category.active = true
	@debit_category.save!(:validate => false)
	
	redirect_to(debit_categories_path, :notice => 'Debit Category Reactivated.')
  end
 
end
