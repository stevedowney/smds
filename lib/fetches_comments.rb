class FetchesComments
	attr_accessor :user, :quote, :comments

	def initialize(user, quote)
		self.user = user
		self.quote = quote
	end

	def newest
		self.comments = quote.comments.newest.limit(limit)
		comments_with_activity
	end

	def comments_with_activity
		comments.map do |comment|
			activity = activities.detect { |act| act.comment_id == comment.id }
			CommentWithActivity.new(user, comment, activity)
		end	
	end

	def activities
		return [] unless user.present?
		
		@activities ||= begin
			raise "Called #activity() before setting comments" unless comments.present?
		  CommentActivity.for_user_and_comments(user, comments)
		end
	end


	def limit
		100
	end
end