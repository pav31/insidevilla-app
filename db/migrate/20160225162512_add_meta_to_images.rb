class AddMetaToImages < ActiveRecord::Migration
  def change
    add_column :images, :attachment_meta, :text
  end
end
