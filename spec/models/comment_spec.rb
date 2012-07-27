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

end
