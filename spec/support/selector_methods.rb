module RSpec::SelectorMethods

  # The default ActiveRecord instance used in various selector and click methods.
  def default_instance(instance = nil)
    if instance.present?
      @default_instance = instance
    elsif @default_instance.present?
      @default_instance
    else
      raise ArgumentError, "default instance not set"
    end
  end

  def create_and_login_user()
    user = FactoryGirl.create(:user, :username => 'test_user', :password => 'secret', :confirmed_at => Time.now)
    login_as(user, :scope => :user)
    user
  end

  def create_and_login_admin_user()
    FactoryGirl.create(:admin_user).tap do |admin_user|
      login_as(admin_user, :scope => :user)
    end
  end
  
  def should_require_admin
    page.should have_content('Admin required')
  end
  
  # def should_have_alert
  #   page.should have_tag('div', :id => 'tb-alert')
  # end
  
  # def should_have_confirm
  #   page.should have_tag('div', :id => 'tb-confirm')
  # end
  
  # def should_be_on_login_page
  #   should_be_on_controller('sessions')
  # end
  
  def have_tag(tag, attributes = {})
    selector = tag.to_s
    text = attributes.delete(:text)

    attributes.each do |k, v|
      selector << "[#{k}='#{v}']"
    end

    args = [selector]
    args << {:text => text} if text
    
    have_css *args
  end

  def should_be_on_controller(controller, action = nil)
    page.should have_tag(:body, 'data-controller' => controller)
    page.should have_tag(:body, 'data-action' => action)  if action.present?
  end
  
  def should_have_tr(instance = default_instance)
    page.should have_tag(:tr, :id => instance.dom_id)
  end
  
  def should_not_have_tr(instance = default_instance)
    page.should_not have_tag(:tr, :id => instance.dom_id)
  end
  
  def should_have_edit_link(instance = default_instance)
    page.should have_tag(:a, :id => instance.dom_id('edit'))
  end

  def should_not_have_edit_link(instance = default_instance)
    page.should_not have_tag(:a, :id => instance.dom_id('edit'))
  end
  
  def should_have_delete_link(instance = default_instance)
    page.should have_tag(:a, :id => instance.dom_id('delete'))
  end

  def should_not_have_delete_link(instance = default_instance)
    page.should_not have_tag(:a, :id => instance.dom_id('delete'))
  end
  
end

RSpec.configure do |config|
  config.include RSpec::SelectorMethods
end