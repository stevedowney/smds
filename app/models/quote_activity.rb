class QuoteActivity < ActiveRecord::Base
  include VotingDetailMethods

  belongs_to :user
	belongs_to :quote

	scope :favorite, where(:favorited => true)
		
  class << self

  	def for_user_and_quotes(user, quotes)
  		find_all_by_user_id_and_quote_id(user.id, quotes.map(&:id))
  	end

  end
end
