module RSpec::SelectorMethods
  
  # def default_instance(instance = nil)
  #   if instance.present?
  #     @default_instance = instance
  #   elsif @default_instance.present?
  #     @default_instance
  #   else
  #     raise ArgumentError, "default instance not set"
  #   end
  # end

  def create_and_login_user()
    FactoryGirl.create(:user, :password => 'secret').tap do |user|
      login_as(user, :scope => :user)
    end
  end

  # def create_and_login_admin_user()
  #   Factory.create(:admin_user).tap do |au|
  #     login(au.username, 'aspera')
  #   end
  # end
  
  # def login(username, password)
  #   visit test_login_path(:username => username, :password => password)
  #   page.should have_content("Test Login Successful")
  # end

  # def visit_login_page
  #   visit login_path
  #   should_be_on_login_page
  # end
  
  # def should_have_alert
  #   page.should have_selector('div', :id => 'aspera-alert')
  # end
  
  # def should_have_confirm
  #   page.should have_selector('div', :id => 'aspera-confirm')
  # end
  
  # def should_be_on_login_page
  #   should_be_on_controller('sessions')
  # end
  
  def should_be_on_controller(controller, action = nil)
    page.should have_selector("body[data-controller=#{controller}]")
    page.should have_selector("body[data-action=#{action}]")  if action.present?
  end
  
  # def should_have_tr(instance = default_instance)
  #   page.should have_selector( %(tr[id='#{instance.dom_id}']) )
  # end
  
  # def should_not_have_tr(instance = default_instance)
  #   page.should_not have_selector( %(tr[id='#{instance.dom_id}']) )
  # end
  
  
end

RSpec.configure do |config|
  config.include RSpec::SelectorMethods
end