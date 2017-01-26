class ChangeFieldsToTranslationForEstates < ActiveRecord::Migration
  def change
    remove_column :estates, :title, :string
    remove_column :estates, :description, :text

    add_column :estates, :title_translations, :hstore
    add_column :estates, :description_translations, :hstore
  end
end
