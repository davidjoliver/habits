require 'rails_helper'

require 'rails_helper'

RSpec.describe StreakManager do
  let(:habit) { Habit.create(name: "Something I want to start doing") }
  let(:manager) {  StreakManager.new(habit: habit) }

  it "Records the check in" do
    expect { manager.check_in(check_in_type: "crushed") }
      .to change { habit.habit_records.where(check_in_type: "crushed").count }
      .by(1)
  end

  it "creates two check ins" do
    Timecop.freeze(1.day.ago) { manager.check_in(check_in_type: "crushed") }
    manager.check_in(check_in_type: "crushed")
    expect(habit.habit_records.where(check_in_type: "crushed").count).to eq 2
  end

  context "when checking in" do
    it "starts a streak" do
      manager.check_in(check_in_type: "crushed")
      expect(habit.streaks.running.count).to eq 1
    end
  end
end
