class Comment < ActiveRecord::Base
  include VotingSummaryMethods
  
  belongs_to :author, :class_name => "User"
  belongs_to :quote
  has_many :activities, :class_name => 'CommentActivity', :dependent => :destroy

  # attr_accessible :author_id, :quote_id, :body, :votes_down, :votes_net, :votes_up
  attr_accessible :quote_id, :body

  # validates :author_id, :presence => true
  validates :quote_id, :presence => true
  validates :body, :presence => true

  scope :newest, order("created_at desc")
  
  def authored_by?(user)
    user && user.id == author_id
  end

  def delete_content(deleter)
    self.deleted = true
    self.deleted_by = deleter
    self.body = "Deleted by #{deleter}"
    self.author_id = 0
    self.vote_up_count = 0
    self.vote_down_count = 0
    self.vote_net_count = 0
    self.flag_count = 0
    self.favorite_count = 0
    save!
  end
end
