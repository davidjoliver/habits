class StreakManager
  attr_reader :habit

  def initialize(habit:)
    @habit = habit
  end

  def check_in(check_in_type:)
    habit.habit_records.create(checked_in_on: DateTime.now, check_in_type: check_in_type)
    streak = habit.streaks.find_or_create_by(habit_id: habit.id, end_date: nil)
    if streak.start_date.nil?
      start_streak(streak)
    end
  end

  def start_streak(streak)
    streak.update(start_date: DateTime.now)
  end
end
