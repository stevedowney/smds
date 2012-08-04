require 'spec_helper'

describe UserMailer do
  
  describe '#send_test_email' do
    let(:mail) { UserMailer.send_test_email('bob@example.com') }
    
    it "sets to" do
      mail.to.should == ['bob@example.com']
    end
  end
  
end