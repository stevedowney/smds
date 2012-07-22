class Comment < ActiveRecord::Base
	belongs_to :author, :class_name => "User"
	belongs_to :quote

  attr_accessible :author_id, :quote_id, :body, :votes_down, :votes_net, :votes_up

  validates :author_id, :presence => true
  validates :quote_id, :presence => true
  validates :body, :presence => true

  def editable_by?(user)
  	authored_by?(user)
  end

  def deletable_by?(user)
  	authored_by?(user)
  end

  def authored_by?(user)
  	user && user.id == author_id
  end

end
