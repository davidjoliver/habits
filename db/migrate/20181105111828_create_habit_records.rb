class CreateHabitRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :habit_records do |t|
      t.integer :habit_id
      t.datetime :crushed_on
      t.datetime :missed_on
      t.timestamps
    end
  end
end
