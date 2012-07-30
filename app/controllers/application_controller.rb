class ApplicationController < ActionController::Base
  before_filter :authenticate_user!

  protect_from_forgery

  def admin?
  	current_user.try(:admin?)
  end
  helper_method :admin?
  
end
