class AddAttachmentToImages < ActiveRecord::Migration
  def up
    add_attachment :images, :attachment
  end

  def down
    remove_attachment :images, :attachment
  end
end
