# Custom validator for email address.
#
#   validates :work_email, :email => true
#   validates :home_email, :email => {:message => "must look like 'name@example.com'"}
#
# Options:
# * :message - error message (default "is not a valid email address")
#
# Note: has side-effect of downcasing email value.
class EmailValidator < ActiveModel::EachValidator

  # http://stackoverflow.com/questions/1156601/whats-the-state-of-the-art-in-email-validation-for-rails
  REGEXP = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}\z/

  def validate_each(object, attribute, value)
    value.replace(value.to_s.downcase) if value.respond_to?(:replace)
    message = options[:message] || "is not a valid email address"

    unless value =~ REGEXP
      object.errors[attribute] << message
    end
  end
  
end