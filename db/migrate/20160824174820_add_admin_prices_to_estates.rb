class AddAdminPricesToEstates < ActiveRecord::Migration
  def change
    change_table :estates do |t|
      t.integer :admin_price_cents,            default: 0, null: false
      t.integer :admin_price_day_low_cents,    default: 0, null: false
      t.integer :admin_price_day_high_cents,   default: 0, null: false
      t.integer :admin_price_day_pick_cents,   default: 0, null: false
      t.integer :admin_price_week_low_cents,   default: 0, null: false
      t.integer :admin_price_week_high_cents,  default: 0, null: false
      t.integer :admin_price_week_pick_cents,  default: 0, null: false
      t.integer :admin_price_month_low_cents,  default: 0, null: false
      t.integer :admin_price_month_high_cents, default: 0, null: false
      t.integer :admin_price_month_pick_cents, default: 0, null: false
    end
  end
end
