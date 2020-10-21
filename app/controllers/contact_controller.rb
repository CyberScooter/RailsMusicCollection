class ContactController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.save

    
    redirect_to contact_url, notice: 'Message has been successfully sent'
    
  end

  private
    def contact_params
      params.require(:contact).permit(:name, :email, :message)
    end

end
