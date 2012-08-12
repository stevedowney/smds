class SharingController < ApplicationController
  skip_before_filter :authenticate_user!

  def email_new
    @sharing_email = SharingEmail.new
  end

  def email_create
    @sharing_email = SharingEmail.new(params.fetch(:sharing_email))
    if @sharing_email.queue_email
      redirect_to root_url, :notice => "Email sent."
    else
      render 'email_new'
    end
  end
end