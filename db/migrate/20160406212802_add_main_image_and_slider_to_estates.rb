class AddMainImageAndSliderToEstates < ActiveRecord::Migration
  def up
    add_attachment :estates, :main_image
    add_attachment :estates, :slider
  end

  def down
    remove_attachment  :estates, :main_image
    remove_attachment  :estates, :slider
  end
end
