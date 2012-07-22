require 'spec_helper'

describe Comment do
	let(:author) { FactoryGirl.create(:author) }
	let(:other_author) { FactoryGirl.create(:author) }
	let(:comment) { FactoryGirl.create(:comment, :author => author) }

	describe '#authored_by?' do
		it "true" do
		  comment.should be_authored_by(author)
		end

		it "false" do
		  comment.should_not be_authored_by(other_author)
		end
	end

	describe "#editable_by?" do
	  it "true for author" do
	    comment.should be_editable_by(author)
	  end

	  it "false for other" do
	    comment.should_not be_editable_by(other_author)
	  end
	end

	describe "#deletable_by?" do
	  it "true for author" do
	    comment.should be_deletable_by(author)
	  end

	  it "false for other" do
	    comment.should_not be_deletable_by(other_author)
	  end
	end
end
