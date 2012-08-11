require 'spec_helper'

describe FeedbacksController do
  
  context 'non-admin' do
    before(:each) do
      create_and_login_user
      visit admin_feedbacks_path
    end
    
    it 'fails' do
      should_require_admin
    end
  end

  context 'admin' do
    let!(:user) { create_and_login_admin_user }
    let!(:feedback) { FactoryGirl.create(:feedback) }
    before { visit admin_feedbacks_path }
    
    it "should show feedback" do
      should_have_tr(feedback)
    end
  end
end