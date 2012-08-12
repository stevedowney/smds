module UrlHelpers
  extend ActiveSupport::Concern
  
  included do
    include Rails.application.routes.url_helpers
    default_url_options[:host] = 'hewasall.com'
  end
  
end