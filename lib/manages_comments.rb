class ManagesComments
	attr_accessor :user

	def initialize(user)
		self.user = user	
	end

	def create(quote, comment_attributes)
		comment = quote.comments.build(comment_attributes)
		comment.author_id = user.id
		if comment.save
			quote.increment!(:comments_count)
		end
	end
	def update(comment, comment_attributes)
		comment.attributes = comment_attributes
		comment.save
	end

	def destroy(comment)
		comment.destroy
		comment.quote.decrement!(:comments_count)
	end
end