class CreateHabitRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :habit_records do |t|
      t.integer :habit_id
      t.datetime :checked_in_on
      t.string :check_in_type
      t.timestamps
    end
  end
end
