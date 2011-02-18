class DabitCategoriesController < ApplicationController
  # GET /dabit_categories
  # GET /dabit_categories.xml
  def index
    @dabit_categories = DabitCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @dabit_categories }
    end
  end

  # GET /dabit_categories/1
  # GET /dabit_categories/1.xml
  def show
    @dabit_category = DabitCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @dabit_category }
    end
  end

  # GET /dabit_categories/new
  # GET /dabit_categories/new.xml
  def new
    @dabit_category = DabitCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @dabit_category }
    end
  end

  # GET /dabit_categories/1/edit
  def edit
    @dabit_category = DabitCategory.find(params[:id])
  end

  # POST /dabit_categories
  # POST /dabit_categories.xml
  def create
    @dabit_category = DabitCategory.new(params[:dabit_category])

    respond_to do |format|
      if @dabit_category.save
        format.html { redirect_to(@dabit_category, :notice => 'Dabit category was successfully created.') }
        format.xml  { render :xml => @dabit_category, :status => :created, :location => @dabit_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @dabit_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /dabit_categories/1
  # PUT /dabit_categories/1.xml
  def update
    @dabit_category = DabitCategory.find(params[:id])

    respond_to do |format|
      if @dabit_category.update_attributes(params[:dabit_category])
        format.html { redirect_to(@dabit_category, :notice => 'Dabit category was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @dabit_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /dabit_categories/1
  # DELETE /dabit_categories/1.xml
  def destroy
    @dabit_category = DabitCategory.find(params[:id])
    @dabit_category.destroy

    respond_to do |format|
      format.html { redirect_to(dabit_categories_url) }
      format.xml  { head :ok }
    end
  end
end
