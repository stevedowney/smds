require 'spec_helper'

describe Comment do
	let(:author) { FactoryGirl.create(:author) }
	let(:other_author) { FactoryGirl.create(:author) }
	let(:comment) { FactoryGirl.create(:comment, :author => author) }

  describe 'validations' do
    it "valid" do
      comment.should be_valid
    end
    
    describe 'body' do
      it "< 2000" do
        comment.body = 'x' * 2000
        comment.should be_valid
        comment.body = 'x' * 2001
        comment.should_not be_valid
      end
    end
  end
  
	describe '#authored_by?' do
		it "true" do
		  comment.should be_authored_by(author)
		end

		it "false" do
		  comment.should_not be_authored_by(other_author)
		end
	end

  describe '#root?' do
    it "true if no parent" do
      comment = FactoryGirl.build(:comment, :parent_id => nil)
      comment.should be_root
    end
    
    it "false if parent" do
      comment = FactoryGirl.build(:comment, :parent_id => 1)
      comment.should_not be_root
    end
  end
  
  describe '#delete_content' do
    it "changes a bunch of fields" do
      # using author in factory makes test on author_id == 0 fail
      comment = FactoryGirl.create(:comment, :author_id => FactoryGirl.create(:user).id) 
      
      int_fields = [:vote_up_count, :vote_down_count, :vote_net_count, :favorite_count, :flag_count]
      int_fields.each do |field|
        comment.send("#{field}=", 42)
      end
      comment.save!
      
      comment.delete_content('foo')

      comment.should be_deleted
      comment.deleted_by.should == 'foo'
      comment.author_id.should == 0
      comment.body.should == "Deleted by foo"
      
      int_fields.each do |field|
        comment.send(field).should == 0
      end
    end
  end
  
end
