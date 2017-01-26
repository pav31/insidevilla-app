class AddMetaToStaticPages < ActiveRecord::Migration
  def change
    add_column :static_pages, :meta, :hstore
  end
end
