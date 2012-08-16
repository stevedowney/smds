require 'spec_helper'

describe QuoteMutatorBase do
  let(:quote) { FactoryGirl.create(:quote)}
  let(:quote_by_user) { FactoryGirl.create(:quote, :owner => user)}
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin_user)}
  let(:qm_user) { QuoteMutatorBase.new(user)}
  let(:qm_admin) { QuoteMutatorBase.new(admin) }
  
  describe '#find_quote' do
    it "admin" do
      qm_admin.find_quote(quote.id)
      qm_admin.quote = quote
    end
    
    it "non_admin" do
      qm_user.find_quote(quote_by_user.id)
      qm_user.quote.should == quote_by_user
    end
    
    it "error if not owner or admin" do
      expect { qm_user.find_quote(quote.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
    
  end
  
  describe '#qwa' do
    it "has quote" do
      qm_user.quote = quote
      qm_user.qwa.quote = quote
    end
  end
  
end