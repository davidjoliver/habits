class Habit < ApplicationRecord
  has_many :habit_records
  has_many :streaks
end
