class SessionsController < ApplicationController
	layout "application"

	def new
		redirect_to root_url
	end

	def create
		user = User.authenticate(params[:login], params[:password])
		if user
			if user.assignments.nil? || user.assignments.empty?
				redirect_to root_url, :notice => "You don't have any assignments right now. Check with Direct of Student Affairs."
			elsif !user.has_active_assignment?
				redirect_to root_url, :notice => "You don't have any assignments right now. Check with Direct of Student Affairs."
			else
				session[:user_id] = user.id
				redirect_to root_url, :notice => "Logged in successfully."
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
