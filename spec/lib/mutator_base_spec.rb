require 'spec_helper'

describe QuoteMutatorBase do
  let(:user) { FactoryGirl.create(:user) }
  let(:mutator_base) { MutatorBase.new(user)}
  
  describe '.initialize' do
    it "sets user" do
      mutator_base.user.should == user
    end
    
    it "raise error if no user passed" do
      expect { MutatorBase.new('') }.to raise_error(MutatorBase::NoUserError)
    end
  end
  
  describe '#admin?' do
    it 'admin' do
      admin = FactoryGirl.create(:admin_user)
      mutator_base_admin = MutatorBase.new(admin)
      mutator_base_admin.admin?.should be_true
      mutator_base_admin.not_admin?.should be_false
    end
    
    it "non-admin" do
      mutator_base.admin?.should be_false
      mutator_base.not_admin?.should be_true
    end
  end
  
end