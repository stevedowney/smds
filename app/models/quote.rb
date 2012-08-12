class Quote < ActiveRecord::Base
  include VotingSummaryMethods

  attr_accessible :who, :text, :context
  belongs_to :owner, :class_name => "User"
  has_many :comments, :dependent => :destroy

  validates :owner, :presence => true
  validates :who, :presence => true
  validates :text, :presence => true, :length => {:maximum => 250}

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
end
