class RemoveMainSliderFeaturedFieldsFromImages < ActiveRecord::Migration
  def change
    remove_column :images, :main, :boolean, default: false
    remove_column :images, :slider, :boolean, default: false
    remove_column :images, :featured, :boolean, default: false
  end
end
