class StreakManager
  attr_reader :errors

  def initialize(habit:)
    @habit = habit
    @check_ins = habit.habit_records.load
    @errors = []
  end

  def check_in(check_in_type:)
    if first_check_in? || missed_day?
      start_streak
    end
    check_in = check_ins.create(checked_in_on: DateTime.now, check_in_type: check_in_type)
    errors << check_in.errors unless check_in.valid?
  end

  def current_streak_count
    return 0 if habit.streaks.currently_running.nil?
    start_streak if missed_day?
    current_streak = habit.streaks.currently_running
    check_ins.where("checked_in_on >= ?", current_streak.start_date).count
  end

  private

  attr_reader :check_ins, :habit

  def start_streak
    reset_streak
    habit.streaks.create(start_date: DateTime.now)
  end

  def reset_streak
    habit.streaks.currently_running&.update(end_date: last_check_in)
  end

  def first_check_in?
    check_ins.empty?
  end

  def missed_day?
    last_check_in.beginning_of_day.utc < (DateTime.now.utc.beginning_of_day - 24.hours)
  end

  def last_check_in
    check_ins.order(checked_in_on: :asc).last&.checked_in_on
  end
end
