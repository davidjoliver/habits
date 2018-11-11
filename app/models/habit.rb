class Habit < ApplicationRecord
  has_many :habit_records
  has_many :streaks

  def current_streak_count
    return 0 if self.streaks.currently_running.nil?
    self.habit_records.where("checked_in_on >= ?", self.streaks.currently_running.start_date).count
  end
end
