class Admin::FeedbacksController < Admin::BaseController

  def index
    @feedbacks = Feedback.includes(:user).order("created_at desc").page(params[:page]).per(5)
  end

end