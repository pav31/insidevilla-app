class AddColumnsToEstates < ActiveRecord::Migration
  def change
    add_column :estates, :area_size, :float
    add_column :estates, :bedrooms, :integer, null: false, default: 1
    add_column :estates, :bathrooms, :integer, null: false, default: 1
  end
end
