class StreakManager
  attr_reader :errors

  def initialize(habit:)
    @habit = habit
    @check_ins = habit.habit_records.load
    @errors = []
  end

  def check_in(check_in_type:)
    streak = habit.streaks.find_or_create_by(habit_id: habit.id, end_date: nil)
    if start_new_streak?(streak)
      start_streak(streak)
    end
    check_in = check_ins.create(checked_in_on: DateTime.now, check_in_type: check_in_type)
    errors << check_in.errors unless check_in.valid?
  end

  private

  attr_reader :check_ins, :habit

  def start_streak(streak)
    streak.update(start_date: DateTime.now)
  end

  def start_new_streak?(streak)
    if streak.start_date.nil? || missed_day?
      start_streak(streak)
    end
  end

  def missed_day?
    last_check_in = check_ins.order(checked_in_on: :asc).last.checked_in_on
    last_check_in.beginning_of_day.utc < (DateTime.now.utc.beginning_of_day - 24.hours)
  end
end
