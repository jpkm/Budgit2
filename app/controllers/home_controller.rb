class HomeController < ApplicationController
  def index
  
  # list of assignments for the user
  @assignment_for_user = Assignment.for_user(current_user.id).all
  
  
  end

end
