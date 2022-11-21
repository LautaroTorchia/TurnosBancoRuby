class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.time :open_at, :null => false
      t.time :close_at, :null => false
      t.string :day, :null => false
      t.belongs_to :branch, null: false, foreign_key: true

      t.timestamps
    end
  end
end
