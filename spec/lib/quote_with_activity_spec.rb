require 'spec_helper'

describe QuoteWithActivity do
	let(:user) { FactoryGirl.create(:user) }
	let(:quote) { FactoryGirl.create(:quote) }
	let(:activity) { user.quote_activity_for(quote) }

	describe '.initialize()' do
		let(:qwa) {QuoteWithActivity.new(user, quote, activity)}

		it 'sets user' do
			qwa.user.should == user
		end

		it 'sets quote' do
			qwa.quote.should == quote
		end

		it 'sets activity' do
			qwa.activity.should == activity
		end
	end
end