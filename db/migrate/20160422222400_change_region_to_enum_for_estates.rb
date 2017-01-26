class ChangeRegionToEnumForEstates < ActiveRecord::Migration
  def up
    add_column :estates, :convert_region, :integer, null: false, default: 0

    # look up the schema's to be able to re-inspect the Project model
    # http://apidock.com/rails/ActiveRecord/Base/reset_column_information/class
    Estate.reset_column_information

    # Write integer values to temp column
    Estate.where(region: 'phuket').update_all(convert_region: 0)
    Estate.where(region: 'phi_phi').update_all(convert_region: 1)
    Estate.where(region: 'krabi').update_all(convert_region: 2)

    # remove the older region column
    remove_column :estates, :region
    # rename the convert_region to region column
    rename_column :estates, :convert_region, :region
  end

  def down
    add_column :estates, :convert_region, :string

    Estate.reset_column_information
    Estate.where(region: 0).update_all(convert_region: 'phuket')
    Estate.where(region: 1).update_all(convert_region: 'phi_phi')
    Estate.where(region: 2).update_all(convert_region: 'krabi')

    remove_column :estates, :region
    rename_column :estates, :convert_region, :region
  end
end
