class QuoteActivity < ActiveRecord::Base
  include VotingDetailMethods

	belongs_to :quote

	scope :favorite, where(:favorited => true)
		
  attr_accessible :favorite, :quote_id, :user_id, :vote_down, :vote_up
  
  class << self

  	def for_user_and_quotes(user, quotes)
  		find_all_by_user_id_and_quote_id(user.id, quotes.map(&:id))
  	end

  end
end
