class RemovePricePeriodFromEstates < ActiveRecord::Migration
  def change
    remove_column :estates, :price_period, :integer
  end
end
