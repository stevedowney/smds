# class ManagesComments
# 	attr_accessor :user

# 	def initialize(user)
# 		self.user = user	
# 	end

# 	def create(comment_attributes)
# 		# quote = Quote.find(quote_id)
# 		comment = Comment.new(comment_attributes)
# 		comment.author_id = user.id
# 		if comment.save
# 			comment.quote.increment!(:comments_count)
# 		end
# 		comment
# 	end

# 	def update(comment, comment_attributes)
# 		comment.attributes = comment_attributes
# 		comment.save
# 	end

# 	def destroy(comment)
# 		comment.destroy
# 		comment.quote.decrement!(:comments_count)
# 	end
# end