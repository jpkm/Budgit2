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
		authorize! :create, @assignment, :message => "action is not authorized"
		
		#if !@assignment.club_id.nil?
		#	@club = @assignment.club
		#	#@roles = @assignment.club.roles_available
		#elsif !@assignment.roles_for_vp_and_sysadmin.nil? || !@assignment.roles_for_vp_and_sysadmin.empty?
		#	@roles = @assignment.roles_for_vp_and_sysadmin
		#	@users = @assignment.available_users
		if !@assignment.available_users.nil? || !@assignment.available_users.empty?
			@users = @assignment.available_users
		end
	
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
		authorize! :create, @assignment, :message => "action not authorized"
		
		unless @user.nil?
			if @assignment.user.assignments.nil? || @assignment.user.assignments.empty? 
				should_send = true
			end
		end
		p should_send
	
		respond_to do |format|
		  if @assignment.save
			if !@assignment.role.name.eql?("system admin") && should_send
				p "i am here1"
				Notifier.welcome_email(@assignment.user).deliver
			end
			p "i am here2"
			if @assignment.role.name.eql?("system admin") || @assignment.role.name.eql?("vp of finance")
				p "i am here3"
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

	def destroy
		@assignment = Assignment.find(params[:id])
		@assignment.destroy!
		
		respond_to do |format|
		  format.html { redirect_to(assignments_url) }
		  format.xml  { head :ok }
		end
	end
	  
	def deactivate2
		@assignment = Assignment.find(params[:id])
		@assignment.active = false
		@assignment.save!(:validate => false)
		
		unless @assignment.club.nil?
			redirect_to((@assignment.club), :notice => 'Assignment deactivated.')
		else
			redirect_to root_url, :notice => 'Assignment deactivated.'
		end
	end
	 
	def reactivate2
		@assignment = Assignment.find(params[:id])
		@assignment.active = true
		
		unless @assignment.save
			redirect_to(assignments_path, :notice => 'Error.')
		else
			redirect_to((assignments_path), :notice => 'Assignment reactivated.')
		end
	end
end
