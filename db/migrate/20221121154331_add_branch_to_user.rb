class AddBranchToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :branch, null: true, foreign_key: true
  end
end
