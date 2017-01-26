class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :email
      t.string :token
      t.boolean :active, default: true, null: false

      t.timestamps null: false
    end
  end
end
