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


  def new
    @assignment = Assignment.new
	@assignment.club_id = params[:club]
	unless @assignment.club_id.nil? || @assignment.club_id.empty?
		@club = @assignment.club
		@available_roles = @assignment.club.roles_available	
		@available_users = @club.free_users
	else
		unless @assignment.roles_for_vp_and_sysadmin.nil? || @assignment.roles_for_vp_and_sysadmin.empty?
			@roles = @assignment.roles_for_vp_and_sysadmin
		end
		unless @assignment.available_users.nil? || @assignment.available_users.empty?
			@users = @assignment.available_users
		end
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
	
    respond_to do |format|
      if @assignment.save
		if @assignment.role.name.eql?("System Admin") || @assignment.role.name.eql?("VP of Finance")
			format.html { redirect_to root_url, :notice => 'Assignment created' }
		else
			format.html { redirect_to(club_path(@assignment.club_id), :notice => 'Assignment was successfully created.') }
			format.xml  { render :xml => @assignment, :status => :created, :location => @assignment }
		end
      else
		@roles = @assignment.roles_for_vp_and_sysadmin
		@users = @assignment.available_users
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
end
