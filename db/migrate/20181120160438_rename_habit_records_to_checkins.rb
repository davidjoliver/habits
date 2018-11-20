class RenameHabitRecordsToCheckins < ActiveRecord::Migration[5.2]
  def change
    rename_table :habit_records, :check_ins
  end
end
