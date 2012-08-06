class Admin::UsersController < Admin::BaseController

  def index
    @users = User.order('username').page(params[:page]).per(20)
  end

end