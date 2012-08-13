class FetchesQuotes
	attr_accessor :user, :params_page, :quotes, :kaminari_object

	def initialize(user, params_page)
		self.user = user
		self.params_page = params_page
	end

	def newest
		self.quotes = Quote.includes(:owner).newest.page(params_page).per(record_limit)
		self.kaminari_object = quotes
		quotes_with_user_activity
	end

	def favorites
		favorite_activities = user.quote_activities.favorite.page(params_page).per(record_limit)
		self.kaminari_object = favorite_activities
		quote_ids = favorite_activities.map(&:quote_id)
		self.quotes = Quote.where(:id => quote_ids).newest
		quotes_with_user_activity
	end

	def quotes_submitted_by(user)
		self.quotes = user.quotes.newest.page(params_page).per(record_limit)
		self.kaminari_object = quotes
		quotes_with_user_activity
	end

	def quotes_with_user_activity
		quotes.map do |quote|
			activity = activity_for_quote(quote)
			QuoteWithActivity.new(user, quote, activity)
		end	
	end

	def activity_for_quote(quote)
		if user.present?
			activities.detect { |act| act.quote_id == quote.id } ||	user.quote_activities.build(:quote_id => quote.id)
		else
			QuoteActivity.new
		end
	end

	def activities
		return [] unless user
		
		@activities ||= begin
			raise "Called #activity() before setting @quotes" unless @quotes.present?
			QuoteActivity.for_user_and_quotes(user, quotes)
		end
	end

	def record_limit
		20
	end
end