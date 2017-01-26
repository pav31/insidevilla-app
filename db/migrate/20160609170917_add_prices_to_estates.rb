class AddPricesToEstates < ActiveRecord::Migration
  def up
    add_column :estates, :price_day_low_cents,    :integer, default: 0, null: false
    add_column :estates, :price_day_mid_cents,    :integer, default: 0, null: false
    add_column :estates, :price_day_high_cents,   :integer, default: 0, null: false
    add_column :estates, :price_week_low_cents,   :integer, default: 0, null: false
    add_column :estates, :price_week_mid_cents,   :integer, default: 0, null: false
    add_column :estates, :price_week_high_cents,  :integer, default: 0, null: false
    add_column :estates, :price_month_low_cents,  :integer, default: 0, null: false
    add_column :estates, :price_month_mid_cents,  :integer, default: 0, null: false
    add_column :estates, :price_month_high_cents, :integer, default: 0, null: false
  end

  def down
    remove_column :estates, :price_day_low_cents
    remove_column :estates, :price_day_mid_cents
    remove_column :estates, :price_day_high_cents
    remove_column :estates, :price_week_low_cents
    remove_column :estates, :price_week_mid_cents
    remove_column :estates, :price_week_high_cents
    remove_column :estates, :price_month_low_cents
    remove_column :estates, :price_month_mid_cents
    remove_column :estates, :price_month_high_cents
  end
end
