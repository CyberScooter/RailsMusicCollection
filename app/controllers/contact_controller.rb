class ContactController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    #creates @contact with params to check against the model validations
    @contact = Contact.new(email: contact_params[:email], name: contact_params[:name], message: contact_params[:message])


    #@contact is used to check if model validations are correct
    if @contact.valid?
      if ContactMailer.contact_email(@contact.name, @contact.email, @contact.message).deliver_now
        redirect_to contact_path, notice: 'Message successfully sent'
      else
        redirect_to contact_path, notice: "Something went wrong, try again later"
      end
    else
      render :new
    end

  end

  private
    def contact_params
      params.require(:contact).permit(:name, :email, :message)
    end

end
