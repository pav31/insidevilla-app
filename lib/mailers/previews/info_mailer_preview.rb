class InfoMailerPreview < ActionMailer::Preview
  def contact_form_request
    InfoMailer.contact_form_request('user@email.com', 'Charles')
  end

  def booking_approved_client
    InfoMailer.booking_approved_client(Booking.first.id)
  end
  def booking_created_client
    InfoMailer.booking_created_client(Booking.first.id)
  end
  def booking_created_system
    InfoMailer.booking_created_system(Booking.first.id)
  end

  def feedback_created_client
    InfoMailer.feedback_created_client(Feedback.first.id)
  end
  def feedback_created_system
    InfoMailer.feedback_created_system(Feedback.first.id)
  end

  def subscribed
    InfoMailer.subscribed(Subscription.active.first.id)
  end
end
