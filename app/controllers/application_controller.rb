class ApplicationController < ActionController::Base
	include ControllerAuthentication
	rescue_from CanCan::AccessDenied do |exception|
		redirect_to root_url, :notice => exception.message
	end
end
