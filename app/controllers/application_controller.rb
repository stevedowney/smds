class ApplicationController < ActionController::Base
  protect_from_forgery

  def admin?
  	current_user.try(:admin?)
  end
  helper_method :admin?
  
end
