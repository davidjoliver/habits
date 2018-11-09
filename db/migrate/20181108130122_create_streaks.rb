class CreateStreaks < ActiveRecord::Migration[5.2]
  def change
    create_table :streaks do |t|
      t.integer :habit_id
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
  end
end
