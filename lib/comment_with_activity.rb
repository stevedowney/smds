class CommentWithActivity
  include ActiveRecordTransaction

  attr_accessor :user, :comment, :activity

  delegate(
    :author,
    :body,
    :comment_number,
    :deleted?,
    :dom_id,
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

  def editable?
    user.admin?
  end
  
  def deletable?
    comment.authored_by?(user) || user.admin?
  end

  def ==(other)
    user == other.user && comment == other.comment && activity == other.activity
  end
  
  # def self.for_user_and_comment(user, comment)
  #   activity = comment.activities.find_or_initialize_by_user_id_and_quote_id(user.id, comment.quote.id)
  #   new(user, comment, activity)
  # end
  class << self

    def for(user, comment)
      activity = user.present? ? user.comment_activity_for(comment) : QuoteActivity.new
      new(user, comment, activity)
    end

  end

end