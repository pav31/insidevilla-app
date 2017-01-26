class AddImageToStaticPages < ActiveRecord::Migration
  def up
    add_attachment :static_pages, :image
  end

  def down
    remove_attachment :static_pages, :image
  end
end
