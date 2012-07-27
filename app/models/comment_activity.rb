class CommentActivity < ActiveRecord::Base
  include VotingDetailMethods

  belongs_to :user
  belongs_to :quote
  belongs_to :comment

  class << self

    def for_user_and_comments(user, comments)
      find_all_by_user_id_and_comment_id(user.id, comments.map(&:id))
    end

  end

end
