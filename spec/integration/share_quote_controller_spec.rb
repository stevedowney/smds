require 'spec_helper'

describe ShareQuoteController do
  
  describe '#by_email', :js => true do
    let!(:quote) { FactoryGirl.create(:quote) }
    let!(:user) { create_and_login_user }
    
    before(:each) do
      default_instance quote
      visit '/'
      # save_and_open_page
      click_on quote.dom_id('email')
    end
    
    context "success" do
      
      it "short form" do
        fill_in 'quote_sharer_by_email_to_email', :with => 'bob@example.com'

        click_on 'Share'

        page.should have_content('Email sent')
      
        mail = ActionMailer::Base.deliveries.first
        mail.to.should == ['bob@example.com']
        mail.subject.should == "New quote from #{user.email}"
        mail.body.should match(/#{quote.formatted}/)
        # mail.from.should == 'foo'
      end
      
      it "long form" do
        click_on 'more'
        
        fill_in 'quote_sharer_by_email_to_email', :with => 'bob@example.com'
        fill_in 'quote_sharer_by_email_subject', :with => 'my subject'
        fill_in 'quote_sharer_by_email_note', :with => 'my note'

        click_on 'Share'

        page.should have_content('Email sent')

        mail = ActionMailer::Base.deliveries.first
        mail.to.should == ['bob@example.com']
        mail.subject.should == "my subject"
        mail.body.should match(/my note/)
        mail.body.should match(/#{quote.formatted}/)
        # mail.from.should == 'foo'
      end
      
    end
    
    it "failure" do
      click_on 'Share'
      page.should have_content("Invalid or missing email address")
    end
  end
  
end