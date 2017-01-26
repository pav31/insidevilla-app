class RenamePricesForEstates < ActiveRecord::Migration
  def up
    rename_column :estates, :price_day_high_cents, :price_day_pick_cents
    rename_column :estates, :price_month_high_cents, :price_month_pick_cents
    rename_column :estates, :price_week_high_cents, :price_week_pick_cents
    rename_column :estates, :price_day_mid_cents, :price_day_high_cents
    rename_column :estates, :price_week_mid_cents, :price_week_high_cents
    rename_column :estates, :price_month_mid_cents, :price_month_high_cents
  end

  def down
    rename_column :estates, :price_day_high_cents, :price_day_mid_cents
    rename_column :estates, :price_week_high_cents, :price_week_mid_cents
    rename_column :estates, :price_month_high_cents, :price_month_mid_cents
    rename_column :estates, :price_day_pick_cents, :price_day_high_cents
    rename_column :estates, :price_month_pick_cents, :price_month_high_cents
    rename_column :estates, :price_week_pick_cents, :price_week_high_cents
  end
end
