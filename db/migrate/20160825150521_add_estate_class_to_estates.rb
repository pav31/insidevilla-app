class AddEstateClassToEstates < ActiveRecord::Migration
  def up
    add_column :estates, :estate_class, :integer, default: 0, null: false

    Estate.reset_column_information
    Estate.find_each { |e| e.update(estate_class: rand(4)) }
  end

  def down
    remove_column :estates, :estate_class
  end
end
