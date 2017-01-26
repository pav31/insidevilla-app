class AddIslandToEstates < ActiveRecord::Migration
  def up
    add_column :estates, :place, :string, default: 'phuket', null: false
    change_column_default :estates, :region, 'phuket_town'

    Estate.find_each do |estate|
      place = estate.place
      region = estate.region
      new_region = region.include?(place) ? region : "#{place}_#{region}"
      estate.update(region: new_region)
    end
  end

  def down
    remove_column :estates, :place
  end
end
