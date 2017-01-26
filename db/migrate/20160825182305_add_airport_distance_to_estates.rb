class AddAirportDistanceToEstates < ActiveRecord::Migration
  def change
    add_column :estates, :airport_distance, :integer
  end
end
