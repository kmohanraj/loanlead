class CreateHousingRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :housing_rentals do |t|
      t.string :name
      t.string :contact
      t.string :society_name
      t.string :block
      t.string :flat_no
      t.string :bedroom
      t.string :square_feet
      t.string :rental_amt
      t.string :deposit
      t.string :negotiable
      t.string :site_visit
      t.string :remarks

      t.timestamps
    end
  end
end
