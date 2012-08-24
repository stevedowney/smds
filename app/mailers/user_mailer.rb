class UserMailer < ActionMailer::Base
  default from: "no-reply@HeWasAll.com"

  def send_test_email(email)
    @email = email
    @url  = "http://example.com/login"
    mail(:to => email, :subject => "Welcome to My Awesome Site")
  end
  
  def send_share_email(sharing_email)
    @root_url = root_url
    @signup_url = new_user_registration_url
    @feedback_url = new_feedback_url
    @sharing_email = sharing_email
    mail(:to => @sharing_email.to_email, :subject => @sharing_email.subject)
  end
end
