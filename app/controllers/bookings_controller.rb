class BookingsController < InheritedResources::Base
  belongs_to :estate

  def create
    create! { signed_in? ? collection_url : parent_url }
    InfoMailer.booking_created_system(@booking.id)
  end

  def update
    update! { collection_url }

  end

  private

  def booking_params
    params.require(:booking).permit(:move_in_at, :move_out_at, :name, :email, :phone_number, :adults, :kids, :comment, :car_rental, :airport_transfer, :escort_service, :status)
  end
end
