class AddLatLongToEstates < ActiveRecord::Migration
  def up
    rename_column :estates, :latitude, :lat
    rename_column :estates, :longitude, :long

    add_column :estates, :latitude, :float
    add_column :estates, :longitude, :float
  end

  def down
    remove_column :estates, :latitude, :float
    remove_column :estates, :longitude, :float

    rename_column :estates, :lat, :latitude
    rename_column :estates, :long, :longitude
  end
end
