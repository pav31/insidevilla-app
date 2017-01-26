class CreateStaticPages < ActiveRecord::Migration
  def change
    create_table :static_pages do |t|
      t.string :title
      t.text :content
      t.integer :category

      t.timestamps null: false
    end
  end
end
