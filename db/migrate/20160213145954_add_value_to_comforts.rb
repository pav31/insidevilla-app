class AddValueToComforts < ActiveRecord::Migration
  def change
    add_column :comforts, :value, :string
  end
end
