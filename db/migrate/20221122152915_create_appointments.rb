class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.references :client, null: false, foreign_key: { to_table: :users }
      t.references :branch, null: false, foreign_key: true
      t.date :date, null: false
      t.string :motive, null: false
      t.integer :status, null: false, default: 0
      t.references :employee, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
