class UsersController < ApplicationController
	before_filter :login_required, :except => [:new, :create]
	layout "application"
	
	def index
		@users = User.all.paginate :page => params[:page], :per_page => 20
		
		respond_to do |format|
		  format.html  #index.html.erb
		  format.xml  { render :xml => @users }
		end
	end
	 
	def show
		@user = User.find(params[:id])
		respond_to do |format|
		  format.html # show.html.erb
		  format.xml  { render :xml => @user }
		end
	end
		
	def new
		@user = User.new
		authorize! :create, @user, :message => "no"
	end

	def create
		@user = User.new(params[:user])
		authorize! :create, @user, :message => "no"
		respond_to do |format|
		  if @user.save 
			format.html { redirect_to root_url, :notice => 'New User created' }
		  else
			format.html { render :action => "new" }
			format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
		  end
		end
	end

	def edit
		@user = current_user
	end

	def update
		@user = current_user
		if @user.update_attributes(params[:user])
		  redirect_to root_url, :notice => "Your profile has been updated."
		else
		  render :action => 'edit'
		end
	end	  
end
