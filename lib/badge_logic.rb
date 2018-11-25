class BadgeLogic
  attr_reader :habit

  def initialize(habit: )
    @habit = habit
  end

  def maybe_award_badge
    habit.badges.create(name: "First check in!") if first_time?
  end

  private

  def first_time?
    habit.check_ins.size == 1
  end
end
