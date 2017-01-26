class CreateComforts < ActiveRecord::Migration
  def change
    create_table :comforts do |t|
      t.string :name, null: false
      t.integer :category, null: false, default: 1
      t.attachment :icon

      t.timestamps null: false
    end
  end
end
