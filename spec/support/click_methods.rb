module RSpec::ClickMethods
  
  # click_on_foo() same as click_on_action('foo')
  def method_missing(method, *args)
    if method.to_s =~ /^click_on_(.*)$/
      action = $1
      @instance = args.shift
      click_on_action(action, *args)
    else
      super
    end
  end
  
  # def click_on_index
  #   click_on "index_link"
  # end
  # 
  # def click_on_new
  #   click_on "new-link"
  # end
  # 
  # def click_on_cancel
  #   click_on "cancel-btn"
  # end
  
  def click_on_action(action, instance = default_instance)
    click_on instance.dom_id(action)
  end
  
  # def click_on_alert_ok
  #   click_on 'tb-alert-ok-btn'
  # end
  
  def click_on_confirm_ok
    verify_confirm_dialog_visible!
    click_on 'tb-confirm-ok-btn'
  end
  
  def click_on_confirm_cancel
    verify_confirm_dialog_visible!
    click_on 'tb-confirm-cancel-btn'
  end
  
  def verify_confirm_dialog_visible!
    cd = find('#tb-confirm')
    cd.visible? or raise 'Confirm dialog is not visible'
  end
  
  # def confirm_delete(instance = nil)
  #   click_on "delete-confirm"
  # end
  # 
  # def confirm_delete_js
  #   page.driver.browser.switch_to.alert.accept    
  # end
  # 
  # def cancel_delete
  #   click_on "delete-cancel"
  # end
  # 
  # def cancel_delete_js
  #   page.driver.browser.switch_to.alert.dismiss
  # end
  
end

RSpec.configure do |config|
  config.include RSpec::ClickMethods
end