require 'spec_helper'


describe 'SuccessPredicate' do
  
  class SPTest
    include SuccessPredicate
  end

  let(:instance) { SPTest.new }
  
  describe '#success?' do
    it "true" do
      instance.success = true
      instance.should be_success
    end
    
    it "false" do
      instance.success = false
      instance.should_not be_success
    end
    
    it "error" do
      expect { instance.success? }.to raise_error(SuccessPredicate::CalledEarlyError)
    end
  end
  
  
end