require 'spec_helper'

describe EmailValidator do

  class EmailFoo
    include ActiveModel::Validations
    
    attr_accessor :email_1, :email_2
    
    validates :email_1, :email => true
    validates :email_2, :allow_nil => true, :email => { :message => 'email_message'}
    
    def initialize(attributes = {})
      attributes.each { |k, v| self.send("#{k}=", v)  }
    end
  end

  it "requires value by default" do
    EmailFoo.new.should_not be_valid
  end
  
  it "invalid amail" do
    EmailFoo.new(:email_1 => 'xx').should_not be_valid
  end
  
  it "valid email" do
    EmailFoo.new(:email_1 => 'user@example.com').should be_valid
  end
  
  it "uses :message" do
    foo = EmailFoo.new(:email_1 => 'user@example.com', :email_2 => 'bogus')
    foo.valid?
    foo.errors[:email_2].first.should == 'email_message'
  end
end