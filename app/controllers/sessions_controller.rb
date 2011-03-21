class SessionsController < ApplicationController
	layout "application"

  def new
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
		if user.assignments.nil? || user.assignments.empty?
			redirect_to root_url, :notice => "You don't have any assignments right now. Check yoself."
		elsif !user.has_active_assignment?
			redirect_to root_url, :notice => "You don't have any assignments right now. Check yoself."
		else
			session[:user_id] = user.id
			redirect_to_target_or_default root_url, :notice => "Logged in successfully."
		end
	else
		redirect_to root_url, :notice => "Invalid login or password."
    end
  end
   

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "You have been logged out."
  end
end
