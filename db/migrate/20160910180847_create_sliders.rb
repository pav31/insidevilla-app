class CreateSliders < ActiveRecord::Migration
  def change
    create_table :sliders do |t|
      t.hstore :title_translations
      t.hstore :text_translations
      t.attachment :image
      t.integer :priority
      t.boolean :active

      t.timestamps null: false
    end
  end
end
