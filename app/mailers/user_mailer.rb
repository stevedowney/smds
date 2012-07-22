class UserMailer < ActionMailer::Base
  default from: "from@example.com"

def send_test_email(email)
    @email = email
    @url  = "http://example.com/login"
    mail(:to => email, :subject => "Welcome to My Awesome Site")
  end
end
