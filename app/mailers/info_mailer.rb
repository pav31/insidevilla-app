class InfoMailer < ApplicationMailer
  before_action :set_system_email

  helper ApplicationHelper

  # Sends notification to customer
  # TODO: DELETE mailer??
  def contact_form_request(email, name)
    @email = email
    @name = name
    mail(to: @email, subject: I18n.t('mailer.contact_form_request.subject'))
  end

  # Notifies client that booking approved
  def booking_approved_client(booking_id)
    @booking = Booking.find(booking_id)
    mail(to: @booking.email, subject: I18n.t('mailer.booking_approved_client.subject'))
  end

  # Notifies client about new booking
  def booking_created_client(booking_id)
    @booking = Booking.find(booking_id)
  # fixme: Net::SMTPSyntaxError: 501 Invalid RCPT TO address provided
    mail(to: @booking.email, subject: I18n.t('mailer.booking_created_client.subject'))
  end
  # Notifies admin about new booking
  def booking_created_system(booking_id)
    @booking = Booking.find(booking_id)
    mail(to: @system_email, subject: I18n.t('mailer.booking_created_system.subject'))
  end

  # TODO: Уведомляет клиента, за неделю до заселения
  # def booking_reminder
  # end

  # TODO: Уведомляет клиента о просьбе не забыть оставить отзыв после того как закончено проживание.
  # def feedback_inqiury
  # end

  # Notifies client that feedback received
  def feedback_created_client(feedback_id)
    @feedback = Feedback.find(feedback_id)
    mail(to: @feedback.email, subject: I18n.t('mailer.feedback_created_client.subject'))
  end
  # Notifies admin about new feedback
  def feedback_created_system(feedback_id)
    @feedback = Feedback.find(feedback_id)
    @estate = @feedback.estate
    mail(to: @system_email, subject: I18n.t('mailer.feedback_created_system.subject'))
  end

  # TODO: Уведомляет нас о добавлении нового обьекта в базу
  # def property_created_system
  # end

  # TODO: Уведомляет собственника,  что обьект ожидает подтверждения
  # def property_created_client
  # end

  # TODO: Уведомляет собственника,  что обьект выложен на сайте
  # def property_confirmed_client
  # end

  # Notifies client about subscription
  # Письмо подписки на рассылку
  def subscribed(subscription_id)
    @subscription = Subscription.active.find(subscription_id)
    email = @subscription.email
    @unsubscribe_link = root_url + "subscriptions/#{@subscription.id}/unsubscribe?del=#{@subscription.token}"
    mail(to: email, subject: I18n.t('mailer.subscription.subject'))
  end

  private

  def set_system_email
    @system_email = Settings.system_email_to || User.first.email
  end
end