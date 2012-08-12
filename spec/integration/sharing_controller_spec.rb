require 'spec_helper'

describe SharingController do
  
  describe 'email' do
    before { visit sharing_email_path }
    
    it "success" do
      fill_in 'sharing_email_from_name', :with => "Bob Jones"
      fill_in 'sharing_email_to_name', :with => "bob@example.com"
      fill_in 'sharing_email_to_email', :with => "bob@example.com"
      fill_in 'sharing_email_subject', :with => "Check this out"
      fill_in 'sharing_email_body', :with => 'share_body'

      click_on 'submit'

      page.should have_content('Email sent')
      mail = ActionMailer::Base.deliveries.first
      mail.to.should == ['bob@example.com']
      mail.subject.should == 'Check this out'
      mail.body.should match(/share_body/)
      # mail.from.should == 'foo'
    end
    
    it "failure" do
      click_on 'submit'
      page.should have_content("can't be blank")
    end
  end
  
end