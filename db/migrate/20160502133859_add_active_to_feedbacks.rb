class AddActiveToFeedbacks < ActiveRecord::Migration
  def up
    add_column :feedbacks, :active, :boolean, default: false, null: false
    Feedback.update_all(active: true)
  end

  def down
    remove_column :feedbacks, :active
  end
end
