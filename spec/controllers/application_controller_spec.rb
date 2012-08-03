require 'spec_helper'

describe ApplicationController do
  
  describe '#admin?' do
    it "true for admin users" do
      controller.stub!(:current_user).and_return(stub(:admin? => true))
      controller.should be_admin
    end
    
    it "false for non-admins" do
      controller.stub!(:current_user).and_return(stub(:admin? => false))
      controller.should_not be_admin
    end
    
    it "false when no user" do
      controller.stub!(:current_user).and_return(nil)
      controller.should_not be_admin
    end
  end
  
end