class Feedback < ActiveRecord::Base
  Feedback.inheritance_column = 'no_inheritance_column'
  
  belongs_to :user
  
  attr_accessible :type, :subject, :body
  
  validates :subject, :length => {:maximum => 60}
  validates :body, :length => {:maximum => 2000}
  validate :validate_subject_or_body
  
  TYPES_HASH = {
    'comment' => 'Comment',
    'suggestion' => 'Suggestion',
    'praise' => 'Praise',
    'criticism' => 'Criticism',
    'bug' => 'Report a problem',
  }

  def self.types_options_for_select
    TYPES_HASH.map { |k, v| [v, k]  }
  end
  
  def validate_subject_or_body
    if [subject, body].all? { |attr| attr.blank? }
      errors.add(:base, "Enter something in Subject or Body")
    end
  end
  
end