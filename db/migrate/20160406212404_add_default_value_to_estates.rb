class AddDefaultValueToEstates < ActiveRecord::Migration
  def up
    change_column :estates, :price_period, :integer, default: 0, null: false
  end

  def down
    change_column :estates, :price_period, :integer, default: nil, null: true
  end
end
