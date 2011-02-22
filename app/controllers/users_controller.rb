class UsersController < ApplicationController
	layout "application"
	before_filter :login_required, :except => [:new, :create]
  #include AuthenicatedSystem 
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
	#@user.password ='secret'
	#@user.password_confirmation ='secret'
	#@user.active = true
	
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Thank you for signing up! You are now logged in."
    else
      render :action => 'new'
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
