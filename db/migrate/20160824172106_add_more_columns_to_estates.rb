class AddMoreColumnsToEstates < ActiveRecord::Migration
  def change
    change_table :estates do |t|
      t.string :closest_beach
      t.integer :toilets
      t.integer :double_beds
      t.integer :single_beds
      t.integer :cleaning_period
      t.float :living_area
      t.string :photo_link
      t.text :comment
      t.string :commission_long_term
      t.string :commission_short_term
      t.string :owner_name
      t.string :owner_phone
      t.string :owner_email
    end
  end
end