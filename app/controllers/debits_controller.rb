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

	#why no Authorization
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
		authorize! :create, @debit, :message=> "Action Not Authorized"
		@account = Account.find(params[:account])
		unless @account.active
			redirect_to club_path(@debit.account.club), :notice=>"Action Not Authorized"
		else
			@debit.reimbursement_date = "null"
			
			respond_to do |format|
				format.html # new.html.erb
				format.xml  { render :xml => @debit }
			end
		end
	end

	def edit
		@debit = Debit.find(params[:id])
		authorize! :edit, @debit, :message => "Action Not Authorized"
	end

	def create
		@debit = Debit.new(params[:debit])
		@debit.reimbursement_date = "null"
		authorize! :create, @debit, :message => "Action Not Authorized"
		
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

	def update
		@debit = Debit.find(params[:id])
		authorize! :update, @debit, :message => "Action Not Authorized"
		
		respond_to do |format|
		  if @debit.update_attributes(params[:debit])
			format.html { redirect_to(debit_path(@debit), :notice => 'Debit was successfully updated.') }
			format.xml  { head :ok }
		  else
			format.html { render :action => "edit" }
			format.xml  { render :xml => @debit.errors, :status => :unprocessable_entity }
		  end
		end
	end

	  
	def delete_debit
		@debit = Debit.find(params[:id])
		@debit.destroy
		redirect_to(@debit.account.club)
	end

	def reimburse
		@debit = Debit.find(params[:id])
		authorize! :reimburse, @debit, :message => "Action Not Authorized"
		@debit.reimbursement_date = DateTime.now
		@debit.status = "reimbursed"
		@debit.save!
		Notifier.reimburse_email(@debit.account.club.get_leader, @debit).deliver
		redirect_to club_path(@debit.account.club), :notice=>"Debit Reimbursed"
	end
	
	def process_me
		@debit = Debit.find(params[:id])
		authorize! :process_me, @debit, :message => "Action Not Authorized"
		@debit.status = "ready"
		@debit.save!
		Notifier.ready_email(@debit.account.club.get_leader, @debit).deliver
		redirect_to club_path(@debit.account.club), :notice=>"Debit Readied"
	end
	
	def claim
		@debit = Debit.find(params[:id])
		p @debit
		authorize! :claim, @debit, :message => "Action Not Authorized"
		@debit.status = "processing"
		@debit.save!
		Notifier.claimed_email(@debit.account.club.get_leader, @debit).deliver
		redirect_to club_path(@debit.account.club), :notice=>"Debit sent for Processing"
	end
	  
end



