class Admin::UsersController < Admin::BaseController

	def index
		@users = User.order('username')
	end
end