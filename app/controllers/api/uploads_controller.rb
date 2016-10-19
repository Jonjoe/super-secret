class Api::UploadsController < ApplicationController
  # Bypass CSRF Protection
  protect_from_forgery with: :null_session
  skip_before_action  :verify_authenticity_token

  def reciever
    params["emails"].each do |email|
      email["recipients"].each do |recipient|
        recipient = Recipient.find_or_initialize_by(
          email_address:recipient
        )

        recipient.save

        recipient.emails.create(
          subject: email["subject"].split(" "),
          sent_on: email["timestamp"]
        )
      end # end of recipients loop
    end
  end
end
