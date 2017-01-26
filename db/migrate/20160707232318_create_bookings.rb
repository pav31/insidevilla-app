class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.date       :move_in_at
      t.date       :move_out_at
      t.belongs_to :estate,           index: true
      t.string     :name
      t.string     :email
      t.string     :phone_number
      t.integer    :adults,                         default: 1
      t.integer    :kids,                           default: 0
      t.integer    :status,                         default: 0
      t.text       :comment
      t.boolean    :airport_transfer,               default: false, null: false
      t.boolean    :car_rental,                     default: false, null: false
      t.boolean    :escort_service,                 default: false, null: false

      t.timestamps null: false
    end
  end
end
