class RenameColumnToApprovedForFeedbacks < ActiveRecord::Migration
  def change
    rename_column :feedbacks, :active, :approved
  end
end
