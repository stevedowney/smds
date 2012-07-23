class Admin::BaseController < ApplicationController
	before_filter :authenticate_user!
	before_filter :require_admin
	

	private

	def require_admin
		unless admin?
			redirect_to root_path, :notice => 'Admin required'
		end
	end
end