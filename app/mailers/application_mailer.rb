class ApplicationMailer < ActionMailer::Base

  def self.mailer_defaults
    {
      :from => (App.development? ? %("Dev HeWasAll.com" <no-reply@hewasall.com>) : %("HeWasAll.com" <no-reply@hewasall.com>) )
    }
  end
  
  default mailer_defaults
  
end