require 'spec_helper'

describe Feedback do

  describe 'validations' do
    let(:feedback) {FactoryGirl.create(:feedback)}
    
    describe 'presence' do
      let(:feedback) {FactoryGirl.build(:feedback, :subject => '', :body => '')}
      
      it "subject and body blank invalid" do
        feedback.should_not be_valid
      end

      it "subject present makes valid" do
        feedback.subject = 'x'
        feedback.should be_valid
      end

      it "body present makes it valid" do
        feedback.body = 'x' 
        feedback.should be_valid
      end
    end
    
    describe 'length' do
      it "subject <= 60" do
        feedback.subject = 'x' * 61
        feedback.should_not be_valid
      end
    end
  end
end