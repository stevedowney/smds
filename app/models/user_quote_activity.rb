class UserQuoteActivity < ActiveRecord::Base
	belongs_to :quote

	scope :favorite, where(:favorite => true)
		
  attr_accessible :comment_count, :favorite, :quote_id, :user_id, :vote_down, :vote_up

  def vote_up!
  	self.vote_up = true
  	self.vote_down = false
  	result = vote_delta
  	save!
  	result
  end

  def vote_down!
  	self.vote_down = true
  	self.vote_up = false
  	result = vote_delta
  	save!
  	result
  end

  def vote_delta
  	up_change = if vote_up_changed?
  		vote_up? ? 1 : -1
  	else
  		0
  	end

  	down_change = if vote_down_changed?
  		vote_down? ? 1 : -1
  	else
  		0
  	end

  	VoteDelta.new(up_change, down_change)
  end

  def favorite!
  	self.favorite = true
  	save!
  end

  def unfavorite!
  	self.favorite = false
  	save!
  end

  class << self
  	def activity_for_user_and_quotes(user, quotes)
  		find_all_by_user_id_and_quote_id(user.id, quotes.map(&:id))
  	end
  end
end
