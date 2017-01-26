class RenameStatusToTenureTypeForEstates < ActiveRecord::Migration
  def change
    rename_column :estates, :status, :tenure_type
  end
end
