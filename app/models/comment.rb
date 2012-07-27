class Comment < ActiveRecord::Base
  include VotingSummaryMethods
  
	belongs_to :author, :class_name => "User"
	belongs_to :quote
  has_many :activities, :class_name => 'CommentActivity', :dependent => :destroy

  attr_accessible :author_id, :quote_id, :body, :votes_down, :votes_net, :votes_up

  validates :author_id, :presence => true
  validates :quote_id, :presence => true
  validates :body, :presence => true

  scope :newest, order("created_at desc")
  
  def authored_by?(user)
  	user && user.id == author_id
  end

  after_create do
    quote.increment!(:comments_count)
  end

  after_destroy do
    quote.decrement!(:comments_count)
  end
end
