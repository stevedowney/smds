class ShareMailer < ActionMailer::Base
  default from: "no-reply@HeWasAll.com"

  def quote(quote_sharer)
    @quote_sharer = quote_sharer
    @root_url = root_url
    @quote_show_url = quote_url(@quote_sharer.quote_id)
    mail(:to => @quote_sharer.to_email, :subject => @quote_sharer.subject)
  end
end