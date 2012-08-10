class FeedbacksController <  ApplicationController
  skip_before_filter :authenticate_user!
  
  def new
    @feedback = Feedback.new
  end
  
  def create
    @feedback = Feedback.new(params.fetch(:feedback))
    @feedback.user = current_user
    @feedback.valid?
    if captcha_ok? && @feedback.save
      redirect_to root_path, :notice => "Thank you for your feedback"
    else
      flash.delete(:recaptcha_error)
      render 'new'
    end
  end
  
  private
  
  def captcha_ok?
    if user_signed_in? || verify_recaptcha
      true
    else
      @feedback.errors.add(:base, "Type the characters you see in the image")
      false
    end
  end
end