class AddWeManageToEstates < ActiveRecord::Migration
  def change
    add_column :estates, :we_manage, :boolean, default: false, null: false
  end
end
