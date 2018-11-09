require 'rails_helper'

RSpec.describe HabitRecord do
  let(:habit) { Habit.create(name: "habit record tests habit") }

  it "does not allow checking in multiple times on the same day" do
    today = DateTime.now
    also_today = today + 1.hour
    valid = HabitRecord.create(checked_in_on: today, habit: habit)
    invalid = HabitRecord.create(checked_in_on: also_today, habit: habit)
    expect(valid).to be_valid
    expect(invalid).to_not be_valid
  end
end
