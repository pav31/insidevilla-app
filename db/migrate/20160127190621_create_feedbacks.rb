class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.belongs_to :estate, index: true, null: false
      t.string :author
      t.string :email
      t.string :city
      t.string :occupation
      t.text :body

      t.timestamps null: false
    end
  end
end
