class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.string :name
      t.string :contact
      t.string :society
      t.string :block
      t.string :flat_number
      t.string :product_feedback
      t.string :executive_feedback

      t.timestamps
    end
  end
end
