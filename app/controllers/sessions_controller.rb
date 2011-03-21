class SessionsController < ApplicationController
	layout "application"

  def new
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
		if user.assignments.nil? || user.assignments.empty?
			redirect_to root_url, :notice => "You don't have any assignments right now. Check yoself."
		elsif user.assignments.count == 1 && user.assignments[0].active
			session[:user_id] = user.id
			redirect_to_target_or_default root_url, :notice => "Logged in successfully."
		else
			for assignment in user.assignments
				unless assignment.active
					break
				end
			redirect_to root_url, :notice => "You don't have any assignments right now. Check yoself."
			end
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
