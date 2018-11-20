class Habit < ApplicationRecord
  has_many :check_ins
  has_many :streaks
end
