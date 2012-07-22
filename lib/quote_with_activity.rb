class QuoteWithActivity

	delegate(
		:subject_verb,
		:text,
		:context,
		:comments,
		:comments_count,
		:votes_net,
		:votes_up,
		:votes_down,
		:owner_name,
		:owner,
		:dom_id,
	 :to => :quote
	 )

	attr_accessor :user, :quote, :activity

	def initialize(user, quote, activity = nil)
		@user = user# or raise "user can't be nil"
		@quote = quote or raise "quote can't be nil"
		@activity = activity || ( user && user.activity_for(@quote) )
	end

	def vote_up!
		vote_response = activity.vote_up!
		quote.update_votes!(vote_response)
	end

	def vote_down!
		vote_response = activity.vote_down!
		quote.update_votes!(vote_response)
	end

	def favorite!
		activity.favorite!
	end

	def unfavorite!
		activity.unfavorite!
	end

	def favorite?
		activity.favorite?
	end

	def owned_by_user?
		quote.owned_by?(user)
	end

	def editable?
		owned_by_user?
	end

	def destroy!
		if deletable?
			quote.destroy
		end
	end

	def deletable?
		owned_by_user?
	end

	def quote_id
		quote.id
	end

end