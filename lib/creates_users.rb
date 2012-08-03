class NotDevelopmentEnvironmentError < StandardError; end

class CreatesUsers
  
  class << self
    
    def create_or_update_admin_user(username, email = nil, password = nil)
      user = User.find_or_initialize_by_username(username)
      user.admin = true
      user.email = email if email.present?
      user.password = password if password.present?
      user.password_confirmation = password if password.present?
      user.confirmed_at ||= Time.now
      user.save!
    end
    
    def create_dev_user(username, password = username)
      raise NotDevelopmentEnvironmentError unless Rails.env == 'development'
      
      gmail_username = ActionMailer::Base.smtp_settings.fetch(:user_name)
      
      User.create! do |user|
        user.username = username
        user.email = "#{gmail_username}+#{username}@gmail.com"
        user.password = password
        user.password_confirmation = password
        user.confirmed_at = Time.now
      end
    end
    
  end
  
end