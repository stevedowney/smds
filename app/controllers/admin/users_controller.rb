class Admin::UsersController < Admin::BaseController

  def index
    @users = User.order('created_at desc').page(params[:page]).per(20)
  end

end