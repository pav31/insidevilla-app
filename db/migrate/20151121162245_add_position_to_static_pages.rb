class AddPositionToStaticPages < ActiveRecord::Migration
  def change
    add_column :static_pages, :position, :integer
  end
end
