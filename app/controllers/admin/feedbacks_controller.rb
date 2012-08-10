class Admin::FeedbacksController < Admin::BaseController

  def index
    @feedbacks = Feedback.order("created_at desc").page(params[:page]).per(5)
  end

end