class AddTranslationToStaticPages < ActiveRecord::Migration
  def change
    enable_extension :hstore
    remove_column :static_pages, :title, :string
    remove_column :static_pages, :content, :text

    add_column :static_pages, :title_translations, :hstore
    add_column :static_pages, :content_translations, :hstore
  end
end
