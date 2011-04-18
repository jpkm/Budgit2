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
		authorize! :create, @debit, :message => "action is not authorized"
		@account = Account.find(params[:account])
		unless @account.active
			redirect_to root_url
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
		authorize! :edit, @debit, :message => "action is not authorized"
	end

	def create
		@debit = Debit.new(params[:debit])
		@debit.reimbursement_date = "null"
		authorize! :create, @debit, :message => "action is not authorized"
		
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
		authorize! :update, @debit, :message => "action is not authorized"
		
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

	  
	def destroy
		@debit = Debit.find(params[:id])
		redirect_to(@debit.account.club)
		@debit.destroy
	end

	def reimburse
		@debit = Debit.find(params[:id])
		authorize! :reimburse, @debit, :message => "action is not authorized"
		@debit.reimbursement_date = DateTime.now
		@debit.status = "reimbursed"
		@debit.save!
		Notifier.reimburse_email(@debit.account.club.get_leader, @debit).deliver
		redirect_to(club_path(@debit.account.club_id), :notice => 'Debit Reimbursed.')
	end
	
	def ready
		@debit = Debit.find(params[:id])
		authorize! :ready, @debit, :message => "action is not authorized"
		@debit.status = "ready"
		@debit.save!
		Notifier.ready_email(@debit.account.club.get_leader, @debit).deliver
		redirect_to(club_path(@debit.account.club_id), :notice => "Debit Ready")
	end
	
	def claim
		@debit = Debit.find(params[:id])
		authorize! :claim, @debit, :message => "action is not authorized"
		@debit.status = "processing"
		@debit.save!
		#Notifier.claimed_email(@debit.account.club.get_leader, @debit).deliver
		redirect_to root_url
		#redirect_to(club_path(@debit.account.club_id), :notice => "Debit Claimed")
	end
	  
end



