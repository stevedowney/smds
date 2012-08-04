require 'spec_helper'

describe Admin::UsersController do
  
  context 'non-admin' do
    before {create_and_login_user}
    
    it "not allowed" do
      visit admin_users_path
      should_require_admin
    end
  end
  
  context 'admin' do
    let!(:admin) {create_and_login_admin_user}
    let!(:user) {FactoryGirl.create(:user, :username => 'alice')}
  
    describe '#index' do
      it "displays users" do
        visit admin_users_path
        page.should have_tag(:tr, :id => user.dom_id)
      end
    end
  end
end