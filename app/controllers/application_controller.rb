class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :set_gon_variables
  
  protect_from_forgery

  if App.test?
    rescue_from Exception do |e|
      logger.debug e.inspect
      logger.debug e.backtrace
      # if request.xhr?
      #   # redirect to error page using window.location (Firefox < version 7 doesn't do redirects
      #   # in ajax requests properly) - https://bugzilla.mozilla.org/show_bug.cgi?id=553888
      #   render 'shared/redirect_to_error', :status => :internal_server_error
      # else
      #   redirect_to error_500_path(:id => @error.database_id)
      # end
    end
  end

  private
  
  def admin?
  	current_user.try(:admin?)
  end
  helper_method :admin?
  
  def require_admin
		unless admin?
			redirect_to root_path, :notice => 'Admin required'
		end
	end

	def set_gon_variables
	  gon.logged_in = user_signed_in?
	  gon.current_username = current_user.try(:username)
	  gon.admin = admin?
  end
  
end
