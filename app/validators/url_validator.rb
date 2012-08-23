# Custom validator for urls.
#
#   validates :work_email, :email => true
#   validates :home_email, :email => {:message => "must look like 'name@example.com'"}
#
# Options:
# * :message - error message (default "is not a valid email address")
#
# Note: has side-effect of downcasing email value.
class UrlValidator < ActiveModel::EachValidator

  # http://www.intridea.com/blog/2009/2/18/quick-tip-url-validation-in-rails
  REGEXP = URI::regexp(%w(http https))

  def validate_each(object, attribute, value)
    message = options[:message] || "is not a valid url"

    unless value =~ REGEXP
      object.errors[attribute] << message
    end
  end
  
end