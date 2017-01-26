class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.request = request
    if @contact.deliver # alias save
      flash[:notice] = I18n.t('flash.notices.email_sent')
      session_keys.each { |key| session.delete key }
      redirect_to root_path
      InfoMailer.contact_form_request(@contact.user_email, @contact.name).deliver_later
    else
      contact_params.except(:nickname).each { |key, val| session[key] = val if val.present? }
      redirect_to_back alert: I18n.t('flash.errors.cannot_send')
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params
    params.require(:contact).permit(:name, :phone_number, :user_email, :message, :nickname)
  end

  def session_keys
    contact_params.keys - [:nickname]
  end
end
