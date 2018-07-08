class CreateLoans < ActiveRecord::Migration[5.2]
  def change
    create_table :loans do |t|
      t.string :name
      t.string :contact_no
      t.string :email
      t.string :loan_amount
      t.integer :status
      t.string :profession
      t.float :salary
      t.string :remarks
      t.string :obligation

      t.timestamps
    end
  end
end
