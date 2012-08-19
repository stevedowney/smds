class ShareQuoteController < ApplicationController
  skip_before_filter :authenticate_user!

  def by_email
    @quote_sharer_by_email = QuoteSharerByEmail.new(:from_email => current_user.email)
    @quote_sharer_by_email.queue_email(params.fetch(:quote_sharer_by_email))
  end

end