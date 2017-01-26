class ChangeAdminPricesToBigintForEstates < ActiveRecord::Migration
  def up
    change_column :estates, :price_cents, :integer, limit: 8
    change_column :estates, :admin_price_cents, :integer, limit: 8

    change_column :estates, :admin_price_day_low_cents, :integer, limit: 8
    change_column :estates, :admin_price_week_low_cents, :integer, limit: 8
    change_column :estates, :admin_price_month_low_cents, :integer, limit: 8
    change_column :estates, :admin_price_day_high_cents, :integer, limit: 8
    change_column :estates, :admin_price_week_high_cents, :integer, limit: 8
    change_column :estates, :admin_price_month_high_cents, :integer, limit: 8
    change_column :estates, :admin_price_day_pick_cents, :integer, limit: 8
    change_column :estates, :admin_price_month_pick_cents, :integer, limit: 8
    change_column :estates, :admin_price_week_pick_cents, :integer, limit: 8
  end

  def down
    change_column :estates, :price_cents, :integer, limit: 4
    change_column :estates, :admin_price_cents, :integer, limit: 4

    change_column :estates, :admin_price_day_low_cents, :integer, limit: 4
    change_column :estates, :admin_price_week_low_cents, :integer, limit: 4
    change_column :estates, :admin_price_month_low_cents, :integer, limit: 4
    change_column :estates, :admin_price_day_high_cents, :integer, limit: 4
    change_column :estates, :admin_price_week_high_cents, :integer, limit: 4
    change_column :estates, :admin_price_month_high_cents, :integer, limit: 4
    change_column :estates, :admin_price_day_pick_cents, :integer, limit: 4
    change_column :estates, :admin_price_month_pick_cents, :integer, limit: 4
    change_column :estates, :admin_price_week_pick_cents, :integer, limit: 4
  end
end
