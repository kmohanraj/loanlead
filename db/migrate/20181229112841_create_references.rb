class CreateReferences < ActiveRecord::Migration[5.2]
  def change
    create_table :references do |t|
      t.string :contact_no
      t.references :feedback, foreign_key: true

      t.timestamps
    end
  end
end
