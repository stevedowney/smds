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
    
    it "failure" do
      click_on 'submit'
      page.should have_content("Enter something in Subject or Body")
      Feedback.count.should == 0
    end
  end
  
end