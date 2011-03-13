class AssignmentsController < ApplicationController
	before_filter :login_required 	
	layout "application"
  # GET /assignments
  # GET /assignments.xml
  def index
	#redirect_to root_url
	
    @assignments = Assignment.all
	
    respond_to do |format|
     format.html # index.html.erb
     format.xml  { render :xml => @assignments }
   end
  end

  # GET /assignments/1
  # GET /assignments/1.xml
  def show
	redirect_to root_url
	
    #@assignment = Assignment.find(params[:id])
    #respond_to do |format|
    #  format.html # show.html.erb
    #  format.xml  { render :xml => @assignment }
    #end
  end

  # GET /assignments/new
  # GET /assignments/new.xml
  def new
    @assignment = Assignment.new
	@assignment.club_id = params[:club]
	
	## gets the free roles for the club (should go in assignment.rb?) 
	##############################################
	@club = @assignment.club	
	
	@roles = []
	for role in Role.all
		unless role.name.eql?("System Admin") || role.name.eql?("VP of Finance")
			@roles << role
		end
	end
	
	@club_roles = []
	for assignment in @club.assignments
		@club_roles << assignment.role
	end
	
	for role in @club_roles
		@roles.delete(role)
	end
	
	#####################################################
	@club_users = []
	for assignment in @club.assignments
		@club_users << assignment.user
	end
	p @club_users
	
	@free_users =[]
	for user in User.all
		for assignment in user.assignments
			if assignment.nil? || assignment.club_id.nil?
				unless assignment.role.name.eql?("System Admin") || assignment.role.name.eql?("VP of Finance")
					@free_users << user
				end
			end
		end
	end
	p @free_users
	
	
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @assignment }
    end
  end

  # GET /assignments/1/edit
  def edit
    @assignment = Assignment.find(params[:id])
  end

  # POST /assignments
  # POST /assignments.xml
  def create
    @assignment = Assignment.new(params[:assignment])
	@assignment.active = true

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to(club_path(@assignment.club_id), :notice => 'Assignment was successfully created.') }
        format.xml  { render :xml => @assignment, :status => :created, :location => @assignment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /assignments/1
  # PUT /assignments/1.xml
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

  # DELETE /assignments/1
  # DELETE /assignments/1.xml
  def destroy
    @assignment = Assignment.find(params[:id])
	@assignment.active = false
	@assignment.save!
	
	redirect_to(@assignment.club)
	
	#respond_to do |format|
    #  format.html { redirect_to(assignments_url) }
    #  format.xml  { head :ok }
    #end
  end
  
  #def deactivate
  	#@assignment = Account.find(params[:id])
	#@assignment.active = false
	#@account.save!
	
	#redirect_to(club_path(@account.club_id), :notice => 'Account deactivated.')
  #end
end
