require 'spec_helper'

describe QuoteMutatorBase do
  let(:quote) { FactoryGirl.create(:quote)}
  let(:quote_by_user) { FactoryGirl.create(:quote, :owner => user)}
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin_user)}
  let(:qm_user) { QuoteMutatorBase.new(user)}
  let(:qm_admin) { QuoteMutatorBase.new(admin) }
  let(:quote_attributes) { {:who => 'who', :text => 'what'} }
  
  describe '.initialize' do
    it "sets user" do
      qm_user.user.should == user
    end
    
    it "raise error if no user passed" do
      expect { QuoteMutatorBase.new('') }.to raise_error(QuoteMutatorBase::NoUserError)
    end
  end
  
  describe '#find_quote' do
    it "admin" do
      qm_admin.find_quote(quote.id)
      qm_admin.quote = quote
    end
    
    it "non_admin" do
      qm_user.find_quote(quote_by_user.id)
      qm_user.quote.should == quote_by_user
    end
  end
  
  describe '#success?' do
    it "true" do
      qm_user.success = true
      qm_user.should be_success
    end
    
    it "false" do
      qm_user.success = false
      qm_user.should_not be_success
    end
    
    it "error" do
      expect { qm_user.success? }.to raise_error(QuoteMutatorBase::SuccessCalledBeforeMutatorCalledError)
    end
  end
  
  describe '#qwa' do
    it "has quote" do
      qm_user.quote = quote
      qm_user.qwa.quote = quote
    end
  end
  
  describe '#admin?' do
    it 'admin' do
      qm_admin.admin?.should be_true
      qm_admin.not_admin?.should be_false
    end
    
    it "non-admin" do
      qm_user.admin?.should be_false
      qm_user.not_admin?.should be_true
    end
  end
  
end