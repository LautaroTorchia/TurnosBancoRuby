class AddUniquenessConstrainToBranch < ActiveRecord::Migration[7.0]
  def change
    add_index :branches, :name, unique: true
  end
end
