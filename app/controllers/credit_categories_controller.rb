class CreditCategoriesController < ApplicationController
	before_filter :login_required
	load_and_authorize_resource
	layout "application"
  
	def index
		@credit_categories = CreditCategory.all

		respond_to do |format|
		  format.html # index.html.erb
		  format.xml  { render :xml => @credit_categories }
		end
	end

	def show
		@credit_category = CreditCategory.find(params[:id])
		
		respond_to do |format|
		  format.html # show.html.erb
		  format.xml  { render :xml => @credit_category }
		end
	end

	def new
		@credit_category = CreditCategory.new
		@credit_category.active = true
		
		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @credit_category }
		end
	end

	def edit
		@credit_category = CreditCategory.find(params[:id])
	end

	def create
		@credit_category = CreditCategory.new(params[:credit_category])	
		
		respond_to do |format|
		  if @credit_category.save
			format.html { redirect_to((credit_categories_path), :notice => 'Credit Category was successfully created.') }
		  else
			format.html { render :action => "new" }
			format.xml  { render :xml => @credit_category.errors, :status => :unprocessable_entity }
		  end
		end
	end

	def update
		@credit_category = CreditCategory.find(params[:id])

		respond_to do |format|
		  if @credit_category.update_attributes(params[:credit_category])
			format.html { redirect_to(@credit_category, :notice => 'Credit Category was successfully updated.') }
			format.xml  { head :ok }
		  else
			format.html { render :action => "edit" }
			format.xml  { render :xml => @credit_category.errors, :status => :unprocessable_entity }
		  end
		end
	end

	def destroy
		@credit_category = CreditCategory.find(params[:id])
		@credit_category.destroy

		respond_to do |format|
		  format.html { redirect_to(credit_categories_url) }
		  format.xml  { head :ok }
		end
	end
	  
	def deactivate3
		@credit_category = CreditCategory.find(params[:id])
		unless @credit_category.category.downcase.eql?("initial") || @credit_category.category.downcase.eql?("special") 
			@credit_category.active = false
			@credit_category.save!(:validate => false)
		
			redirect_to(credit_categories_path, :notice => 'Credit Category Deactivated.')
		else
			redirect_to(credit_categories_path, :notice => 'This category is not allowed to be deactivated')
		end
	end
	  
	def reactivate3
		@credit_category = CreditCategory.find(params[:id])
		@credit_category.active = true
		@credit_category.save!(:validate => false)
		
		redirect_to(credit_categories_path, :notice => 'Credit Category Reactivated.')
	end
	  
end
