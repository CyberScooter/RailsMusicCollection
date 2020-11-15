class ContactController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    #testing purposes will be changed
    #checks against 'contact' model validations
  
    if ContactMailer.contact_email(contact_params[:name], contact_params[:email], contact_params[:message]).deliver_now
      redirect_to contact_path, notice: 'Message successfully sent'
    else
      redirect_to contact_path, notice: 'Message not successfully sent'
    end

  end

  private
    def contact_params
      params.require(:contact).permit(:name, :email, :message)
    end

end
