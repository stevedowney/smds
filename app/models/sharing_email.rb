class SharingEmail
  include ActiveAttr::Model
  # include ActiveAttr::AttributeDefaults
  
  attribute :from_name
  attribute :to_name
  attribute :to_email
  attribute :subject, :default => "He was all ... -- Check out this web site"
  attribute :body, :default => "He was all ... the place to record those outrageous things people say."
  
  validates :to_email, :presence => true, :email => true
  validates :subject, :presence => true
  
  def queue_email
    if valid?
      UserMailer.send_share_email(self).deliver
      true
    end
  end
end