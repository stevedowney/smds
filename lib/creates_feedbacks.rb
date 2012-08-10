class CreatesFeedbacks
  attr_accessor :controller, :feedback
  
  delegate(
    :params,
    :flash,
    :current_user,
    :user_signed_in?,
    :to => :controller
  )
  
  def initialize(controller)
    self.controller = controller
    self.feedback = Feedback.new(params.fetch(:feedback))
    feedback.user = current_user
  end
  
  def create
    feedback.valid?
    if captcha_ok?
      feedback.save
    else
      feedback.errors.add(:base, "Type the characters again")
      flash.delete(:recaptcha_error)
      false
    end
  end
  
  def captcha_ok?
    user_signed_in? || controller.verify_recaptcha
  end
end