class AddSeaDistanceToEstates < ActiveRecord::Migration
  def change
    add_column :estates, :sea_distance, :integer
  end
end
