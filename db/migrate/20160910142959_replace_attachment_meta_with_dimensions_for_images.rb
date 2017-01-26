class ReplaceAttachmentMetaWithDimensionsForImages < ActiveRecord::Migration
  def change
    remove_column :images, :attachment_meta, :text
    add_column :images, :dimensions, :string

    Image.all.map(&:save)
  end
end
