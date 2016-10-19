class HomeController < ApplicationController
  def index
    @recipients = Recipient
      .all
      .paginate(:page => params[:page], :per_page => 6)
    @emails = Email.all

    if params[:query]
      @recipients = Recipient
        .where("email_address LIKE ?", "%#{params[:query]}%")
        .paginate(:page => params[:page], :per_page => 6)
    end
  end
end
