class AddReferenceIdToLoans < ActiveRecord::Migration[5.2]
  def change
    add_column :loans, :reference, :string
  end
end
