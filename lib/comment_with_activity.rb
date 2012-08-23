class CommentWithActivity
  include ActiveRecordTransaction

  attr_accessor :user, :comment, :activity, :child_comments

  delegate(
    :author,
    :body,
    :comment_number,
    :deleted?,
    :dom_id,
    :root?,
    :parent_id,
    :to => :comment,
  )

  delegate(
    :favorited?,
    :flagged?,
    :to => :activity,
    :allow_nil => true
  )

  def initialize(user, comment, activity)
    self.user = user
    self.comment = comment
    self.activity = activity
    self.child_comments = []
  end

  def toggle_vote_up
    transaction do
      vote_response = activity.toggle_vote_up!
      comment.update_votes!(vote_response)
    end
  end

  def toggle_vote_down
    transaction do
      vote_response = activity.toggle_vote_down!
      comment.update_votes!(vote_response)
    end
  end

  def favorite
    return if activity.favorited?

    transaction do
      activity.update_attribute(:favorited, true)
      comment.increment!(:favorite_count, 1)
    end
  end

  def unfavorite
    return unless activity.favorited?

    transaction do
      activity.update_attribute(:favorited, false)
      comment.decrement!(:favorite_count, 1)
    end
  end

  def flag
    return if activity.flagged?

    transaction do
      activity.update_attribute(:flagged, true)
      comment.increment!(:flag_count, 1)
    end
  end

  def unflag
    return unless activity.flagged?

    transaction do
      activity.update_attribute(:flagged, false)
      comment.decrement!(:flag_count, 1)
    end
  end

  def new_comment
    @new_comment ||= Comment.new({:quote_id => comment.quote_id}, :without_protection => true)
  end
  
  def editable?
    user.admin?
  end
  
  def deletable?
    comment.authored_by?(user) || user.admin?
  end

  # TODO: move to presenter
  def username
    @username ||= author.try(:username)
  end
  
  class << self

    def for(user, comment)
      activity = user.present? ? user.comment_activity_for(comment) : QuoteActivity.new
      new(user, comment, activity)
    end

  end

end