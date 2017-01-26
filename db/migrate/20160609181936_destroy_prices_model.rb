class DestroyPricesModel < ActiveRecord::Migration
  def up
    drop_table :prices
  end

  def down
    create_table :prices do |t|
      t.belongs_to :estate, index: true
      t.integer :amount_cents, null: false, default: 0
      t.integer :season, null: false, default: 0
      t.integer :period, null: false, default: 0

      t.timestamps null: false
    end
  end
end
