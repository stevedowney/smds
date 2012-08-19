class QuoteSharerByEmail
  include ActiveAttr::Model
  include SuccessPredicate
  
  attribute :to_email
  attribute :from_email
  attribute :subject#, :default => "He was all ... -- Check out this web site"
  attribute :note
  attribute :quote_id
  
  validates :to_email, :presence => true, :email => {:allow_nil => true}
  validates :subject, :presence => true
  
  def queue_email(attributes)
    set_or_default attributes
    self.success = valid?
    
    if success?
      ShareMailer.quote(self).deliver
      true
    end
  end
  
  def set_or_default(attributes)
    self.attributes = attributes
    self.subject = "New quote from #{from_email}" unless subject?
  end

  def body
    quote = Quote.find(quote_id)
    quote.formatted
  end
end