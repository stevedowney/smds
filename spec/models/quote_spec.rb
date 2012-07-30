require 'spec_helper'

describe Quote do

	describe '#owned_by?' do
		let(:other_user) {FactoryGirl.create(:user)}
		let(:owner) {FactoryGirl.create(:user)}
		let(:quote) {FactoryGirl.create(:quote, :owner => owner)}

		it 'owned by owner' do
			quote.should be_owned_by(owner)
		end

		it "not owned by non-owner" do
		  quote.should_not be_owned_by(other_user)
		end
	end
end
