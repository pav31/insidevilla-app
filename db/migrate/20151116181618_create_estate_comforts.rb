class CreateEstateComforts < ActiveRecord::Migration
  def change
    create_table :estate_comforts do |t|
      t.belongs_to :estate, index: true
      t.belongs_to :comfort, index: true

      t.timestamps null: false
    end
  end
end
