class QuoteWithActivity
  include ActiveRecordTransaction

  delegate(
    :who,
    :text,
    :context,
    :comments,
    :comments_count,
    :vote_net_count,
    :vote_up_count,
    :vote_down_count,
    :owner_name,
    :owner,
    :dom_id,
    :to => :quote
  )

  delegate(
    :favorited?,
    :flagged?,
    :to => :activity,
  )

  attr_accessor :user, :quote, :activity

  def initialize(user, quote, activity)
    self.user = user.presence
    self.quote = quote or raise "need a quote"
    self.activity = activity or raise "need an activity"
  end

  def toggle_vote_up
    transaction do
      vote_response = activity.toggle_vote_up!
      quote.update_votes!(vote_response)
    end
  end

  def toggle_vote_down
    transaction do
      vote_response = activity.toggle_vote_down!
      quote.update_votes!(vote_response)
    end
  end

  def favorite
    return if activity.favorited?

    transaction do
      activity.update_attribute(:favorited, true)
      quote.increment!(:favorite_count, 1)
    end
  end

  def unfavorite
    return unless activity.favorited?

    transaction do
      activity.update_attribute(:favorited, false)
      quote.decrement!(:favorite_count, 1)
    end
  end

  def flag
    return if activity.flagged?

    transaction do
      activity.update_attribute(:flagged, true)
      quote.increment!(:flag_count, 1)
    end
  end

  def unflag
    return unless activity.flagged?

    transaction do
      activity.update_attribute(:flagged, false)
      quote.decrement!(:flag_count, 1)
    end
  end

  def destroy
    if deletable?
      quote.destroy
    end
  end

  def owned_by_user?
    user && quote.owned_by?(user)
  end

  def editable?
    admin? || (owned_by_user? && quote.comments_count == 0)
  end

  def deletable?
    user && (user.admin? || owned_by_user?)
  end

  def admin?
    user && user.admin?
  end
  
  class << self

    def for(user, quote)
      activity = user.present? ? user.quote_activity_for(quote) : QuoteActivity.new
      new(user, quote, activity)
    end

  end

end