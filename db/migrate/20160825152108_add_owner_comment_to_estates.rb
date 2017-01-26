class AddOwnerCommentToEstates < ActiveRecord::Migration
  def change
    add_column :estates, :owner_comment, :text
  end
end
