class AddRegionAndPricePeriodToEstates < ActiveRecord::Migration
  def change
    add_column :estates, :region_translations, :hstore
    add_column :estates, :price_period, :integer
  end
end
