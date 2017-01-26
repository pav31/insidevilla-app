class AddPhotoToFeedbacks < ActiveRecord::Migration
  def up
    add_attachment :feedbacks, :photo
  end

  def down
    remove_attachment :feedbacks, :photo
  end
end
