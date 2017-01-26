class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.boolean :main, default: false, null: false
      t.boolean :slider, default: false, null: false
      t.boolean :featured, default: false, null: false
      t.integer :imageable_id
      t.string :imageable_type

      t.timestamps null: false
    end
  end
end
