class ChangeRegionToStrForEstates < ActiveRecord::Migration
  def change
    remove_column :estates, :region_translations, :hstore
    add_column :estates, :region, :string
  end
end
