class FetchesQuotes
	attr_accessor :current_user, :quotes

	def initialize(current_user)
		@current_user = current_user
	end

	def newest
		@quotes = Quote.newest.limit(record_limit)
		quotes_with_current_user_activity
	end

	def favorites
		favorite_activities = current_user.quote_activities.favorite.limit(record_limit)
		quote_ids = favorite_activities.map(&:quote_id)
		@quotes = Quote.where(:id => quote_ids).newest
		quotes_with_current_user_activity
	end

	def quotes_submitted_by(user)
		@quotes = user.quotes.limit(record_limit).newest
		quotes_with_current_user_activity
	end

	def quotes_with_current_user_activity
		quotes.map do |quote|
			activity = activities.detect { |act| act.quote_id == quote.id } ||
				current_user.quote_activities.build(:quote_id => quote.id)
			QuoteWithActivity.new(current_user, quote, activity)
		end	
	end

	def activities
		return [] unless current_user
		
		@activities ||= begin
			raise "Called #activity() before setting @quotes" unless @quotes.present?
			QuoteActivity.for_user_and_quotes(current_user, quotes)
		end
	end

	def record_limit
		100
	end
end