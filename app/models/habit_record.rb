class HabitRecord < ApplicationRecord
  belongs_to :habit
  validate :only_one_check_in_per_day, on: :create

  def only_one_check_in_per_day
    beginning_of_day = self.checked_in_on.beginning_of_day
    end_of_day = self.checked_in_on.end_of_day

    if(HabitRecord.where("checked_in_on BETWEEN ? and ?", beginning_of_day, end_of_day)
                  .where(habit_id: self.habit_id)
                  .exists?)
      errors.add(:checked_in_on, "can only be done once per day")
    end
  end
end
