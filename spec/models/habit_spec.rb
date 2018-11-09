require 'rails_helper'

RSpec.describe Habit do
  context "with a streak" do
    let(:habit) { Habit.create(name: "A streaking habit") }
    let(:first_day) { DateTime.new }

    it "counts 2 consecutive days" do
      habit.habit_records.create(checked_in_on: first_day)
      habit.habit_records.create(checked_in_on: first_day + 1.day)
      expect(habit.streak).to eq 2
    end

    it "counts 3 consecutive days" do
      habit.habit_records.create(checked_in_on: first_day)
      habit.habit_records.create(checked_in_on: first_day + 1.day)
      habit.habit_records.create(checked_in_on: first_day + 2.days)
      expect(habit.streak).to eq 3
    end

    context "when a day is skipped" do
      it "counts only after the skipped day" do
        habit.habit_records.create(checked_in_on: first_day)
        habit.habit_records.create(checked_in_on: first_day + 2.days)
        expect(habit.streak).to eq 1
      end
    end
  end
end
