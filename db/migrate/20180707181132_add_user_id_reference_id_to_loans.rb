class AddUserIdReferenceIdToLoans < ActiveRecord::Migration[5.2]
  def change
    add_column :loans, :user_id, :integer
  end
end
