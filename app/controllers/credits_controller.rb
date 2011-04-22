class CreditsController < ApplicationController
	before_filter :login_required
	layout "application"
  
	def index
		redirect_to root_url
		#@credits = Credit.all
		#respond_to do |format|
		#  format.html # index.html.erb
		#  format.xml  { render :xml => @credits }
		#end
	end

	def show
		redirect_to root_url
		#@credit = Credit.find(params[:id])
		#respond_to do |format|
		#  format.html # show.html.erb
		#  format.xml  { render :xml => @credit }
		#end
	end

	def new
		@credit = Credit.new
		@credit.account_id = params[:account]
		@account = Account.find(params[:account])
		authorize! :create, @credit, :message => "Action Not Authorized"
		unless @account.active
			redirect_to club_path(@credit.account.club), :notice= >"Action Not Authorized"
		else
			@credit.date = Date.today
			if @account.has_initial?
				@except = CreditCategory.except_initial
			else
				@credit.credit_category = CreditCategory.get_initial
			end

			respond_to do |format|
				format.html # new.html.erb
				format.xml  { render :xml => @credit }
			end
		end
	end

	def edit
		@credit = Credit.find(params[:id])
		authorize! :edit, @credit, :message => "Action Not Authorized"
	end

	def create
		@credit = Credit.new(params[:credit])
		@credit.date = Date.today
		@answer = @credit.account.has_initial?
		@account  = @credit.account
		authorize! :create, @credit, :message => "Action Not Authorized"
		
		respond_to do |format|
		  if @credit.save
			format.html { redirect_to(club_path(@credit.account.club_id), :notice => 'Credit was successfully created.') }
			format.xml  { render :xml => @credit, :status => :created, :location => @credit }
		  else
			if @answer
				@except = CreditCategory.except_initial
			end
			
			format.html { render :action => "new" }
			format.xml  { render :xml => @credit.errors, :status => :unprocessable_entity }
		  end
		end
	end

	def update
		@credit = Credit.find(params[:id])
		authorize! :update, @credit, :message => "Action Not Authorized"

		respond_to do |format|
		  if @credit.update_attributes(params[:credit])
			format.html { redirect_to(club_path(@credit.account.club), :notice =>'Credit was successfully updated.') }
			format.xml  { head :ok }
		  else
			format.html { render :action => "edit" }
			format.xml  { render :xml => @credit.errors, :status => :unprocessable_entity }
		  end
		end
	end

	def delete_credit
		@credit = Credit.find(params[:id])
		
		p @credit
		
		#authorize! :destroy, @credit, :message => "Action Not Authorized"
		@credit.destroy
		redirect_to(@credit.account.club)
		end
	
	
	end
