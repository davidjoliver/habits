class StreakManager
  attr_reader :habit, :errors

  def initialize(habit:)
    @habit = habit
    @errors = []
  end

  def check_in(check_in_type:)
    check_in = habit.habit_records.create(checked_in_on: DateTime.now, check_in_type: check_in_type)
    if check_in.valid?
      streak = habit.streaks.find_or_create_by(habit_id: habit.id, end_date: nil)
      if streak.start_date.nil?
        start_streak(streak)
      end
    else
      errors << check_in.errors
    end
  end

  def start_streak(streak)
    streak.update(start_date: DateTime.now)
  end

  def current_streak_count
    habit.current_streak_count
  end
end
