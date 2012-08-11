require 'spec_helper'

describe FeedbacksController do
  
  context 'not logged in' do
    before(:each) do
      visit new_feedback_path
    end
    
    it 'success' do
      fill_in 'feedback_body', :with => 'my feedback'
      click_on 'submit'
      page.should have_content("Thank you for your feedback")
      Feedback.first.body.should == 'my feedback'
    end
    
    it "failure -validation" do
      click_on 'submit'
      page.should have_content("Enter something in Subject or Body")
      Feedback.count.should == 0
    end
    
    it "failure - recaptcha" do
      FeedbacksController.any_instance.stub(:verify_recaptcha).and_return(false)
      fill_in 'feedback_body', :with => 'my feedback'
      click_on 'submit'
      page.should_not have_content("Thank you for your feedback")
      Feedback.count.should == 0
    end
  end
  
end