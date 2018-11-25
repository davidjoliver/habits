class CreateBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :badges do |t|
      t.string :name
      t.integer :habit_id
      t.integer :trigger
    end
  end
end
