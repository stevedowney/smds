class Quote < ActiveRecord::Base
  include VotingSummaryMethods

  belongs_to :owner, :class_name => "User"
  has_many :comments, :dependent => :destroy

  validates :owner, :presence => true
  validates :who, :presence => true, :length => {:maximum => 100}
  validates :text, :presence => true, :length => {:maximum => 2000}
  validates :context, :length => {:maximum => 2000}
  validates :url, :length => {:maximum => 250}, :url => {:allow_blank => true}

  attr_accessible :who, :text, :context, :url

  scope :newest, order("quotes.created_at desc")

  def owned_by?(user)
    owner_id? && owner_id == user.id
  end

  def formatted
    String.new.tap do |s|
      s << "#{who} said: #{text}"
      s << " -- #{context}" if context.present?
    end
  end
  
  def formatted_previously_changed?
    (previous_changes.keys & ['who', 'text', 'context']).present?
  end
  
  def twitter_id
    twitter_update_id_str.presence.try(:to_i)
  end
  
  def has_comments?
    comments_count > 0
  end
end
