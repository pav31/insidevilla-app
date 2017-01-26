class AddFavoriteToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :favorite, :boolean, null: false, default: false
  end
end
