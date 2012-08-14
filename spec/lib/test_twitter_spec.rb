require 'spec_helper'

describe TestTwitter do
  let(:tweet) { TestTwitter.timeline.first }

  before(:each) do
    TestTwitter.timeline.size.should == 0
    TestTwitter.update("foo")
    TestTwitter.timeline.size.should == 1
  end
  
  describe '.update' do
    
    describe 'success' do
      it "adds tweet to timeline" do
        tweet.text.should == 'foo'
      end
    
      it "accumulates tweets" do
        TestTwitter.update('bar')
        TestTwitter.timeline.map(&:text).should == ['foo', 'bar']
      end
    end
    
    describe '140 char limit' do
      it "140 is okay" do
        expect { TestTwitter.update( 'x' * 140) }.to_not raise_error(Twitter::Error::Forbidden)
      end
      
      it "141 not okay" do
        expect { TestTwitter.update( 'x' * 141) }.to raise_error(Twitter::Error::Forbidden)
      end
    end
  end
  
  describe '.status_destroy' do
    it "destroys" do
      TestTwitter.status_destroy(tweet.id)
      TestTwitter.timeline.size.should == 0
    end
    
    it "destroys correct one" do
      tweet2 = TestTwitter.update('bar')
      TestTwitter.status_destroy(tweet.id)
      TestTwitter.timeline.size.should == 1
      TestTwitter.timeline.first.id.should == tweet2.id
    end
    
    it "raises error if tweet not found" do
      expect { TestTwitter.status_destroy(1) }.to raise_error(Twitter::Error::NotFound)
    end
  end
  
end