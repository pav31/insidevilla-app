class AddTranslationToComforts < ActiveRecord::Migration
  def change
    remove_column :comforts, :name, :string
    add_column :comforts, :name_translations, :hstore
  end
end
