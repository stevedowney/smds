require 'spec_helper'

describe CreatesUsers do
  
  describe '.create_or_update_admin_user' do
    
    it "creates new admin user" do
      CreatesUsers.create_or_update_admin_user('bob', 'bob@example.com', 'secret')
      user = User.find_by_username!('bob')
      user.email.should == 'bob@example.com'
      user.should be_admin
      user.should be_valid_password('secret')
    end
    
    it "makes existing user an admin" do
      FactoryGirl.create(:user, :username => 'bob', :admin => false)
      CreatesUsers.create_or_update_admin_user('bob')
      User.find_by_username!('bob').should be_admin
    end
    
  end
  
  describe '.create_dev_user' do
    
    it "creates user" do
      Rails.stub!(:env).and_return('development')
      CreatesUsers.create_dev_user('alice')
      user = User.find_by_username!('alice')
      user.should be_valid_password('alice')
    end
    
    it "only runs in development" do
      expect {CreatesUsers.create_dev_user('alice')}.to raise_error(NotDevelopmentEnvironmentError)
    end
  end
  
end