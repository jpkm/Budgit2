class AssignmentsController < ApplicationController
	before_filter :login_required 	
	layout "application"

	def index
		redirect_to root_url
		#@assignments = Assignment.all
		#authorize! :read, @assignments, :message => "no"
		#respond_to do |format|
		# format.html # index.html.erb
		# format.xml  { render :xml => @assignments }
	   #end
	end

	def show
		redirect_to root_url
	
		#@assignment = Assignment.find(params[:id])
		#respond_to do |format|
		#  format.html # show.html.erb
		#  format.xml  { render :xml => @assignment }
		#end
	end


	def new
		@assignment = Assignment.new
		@assignment.club_id = params[:club]
		@assignment.role_id = params[:role]
		authorize! :create, @assignment, :message => "Action Not Authorized"
		@free_users = User.free_users(@assignment.club, @assignment.role)
	
		respond_to do |format|
			format.html  #new.html.erb
			format.xml  { render :xml => @assignment }
		end
	end

  
	def edit
		@assignment = Assignment.find(params[:id])
	end

  
	def create
		@assignment = Assignment.new(params[:assignment])
		@assignment.active = true
		should_send = false
		@user = @assignment.user
		authorize! :create, @assignment, :message => "Action Not Authorized"
		
		unless @user.nil?
			if @assignment.user.assignments.nil? || @assignment.user.assignments.empty? 
				should_send = true
			end
		end
	
		respond_to do |format|
		  if @assignment.save
			if !@assignment.role.name.eql?("system admin") && should_send
				Notifier.welcome_email(@assignment.user).deliver
			end
			if @assignment.role.name.eql?("system admin") || @assignment.role.name.eql?("vp of finance")
				format.html { redirect_to root_url, :notice => 'Assignment created' }
			else
				format.html { redirect_to(club_path(@assignment.club_id), :notice => 'Assignment was successfully created.') }
				format.xml  { render :xml => @assignment, :status => :created, :location => @assignment }
			end
		  else
			@assignment.role_id = params[:role]
			@users = @assignment.available_users
			format.html { render :action => "new" }
			format.xml  { render :xml => @assignment.errors, :status => :unprocessable_entity }
		  end
		end
	end

	def update
		@assignment = Assignment.find(params[:id])

		respond_to do |format|
		  if @assignment.update_attributes(params[:assignment])
			format.html { redirect_to(@assignment, :notice => 'Assignment was successfully updated.') }
			format.xml  { head :ok }
		  else
			format.html { render :action => "edit" }
			format.xml  { render :xml => @assignment.errors, :status => :unprocessable_entity }
		  end
		end
	end
	  
	def delete
		@assignment = Assignment.find(params[:id])
		redirect_to club_path(@assignment.club)
		@assignment.destroy
	end
	 
end
