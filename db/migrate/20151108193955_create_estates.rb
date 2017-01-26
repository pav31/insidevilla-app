class CreateEstates < ActiveRecord::Migration
  def change
    create_table :estates do |t|
      t.string :title
      t.string :address
      t.text :description
      t.integer :price_cents
      t.boolean :featured
      t.boolean :available
      t.boolean :draft
      t.integer :estate_type, default: 0, null: false
      t.integer :status, default: 0, null: false
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
