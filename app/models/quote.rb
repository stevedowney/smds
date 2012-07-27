class Quote < ActiveRecord::Base
  include VotingSummaryMethods

  attr_accessible :subject_verb, :text, :context
  belongs_to :owner, :class_name => "User"
  has_many :comments, :dependent => :delete_all

  validates :owner, :presence => true
  validates :subject_verb, :presence => true
  validates :text, :presence => true
  
  # delegate :owner_name, :to => :owner

  scope :newest, order("quotes.created_at desc")

  # def anonymous?
  #   !owned?
  # end

  # def owned?
  #   owner.present?
  # end

  # # move to presenter

  def owned_by?(user)
    owner_id? && owner_id == user.id
  end
  
  # def owner_name(current_user)
  #   return 'anonymous' if anonymous?
  #   owner == current_user ? 'me' : owner.username
  # end
end
