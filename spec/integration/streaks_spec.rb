require 'rails_helper'

RSpec.describe StreakManager do
  let(:habit) { Habit.create(name: "Something I want to start doing") }
  let(:manager) {  StreakManager.new(habit: habit) }

  describe "for current streak count" do
    context "when there is no current streak" do
      it "just returns zero" do
        expect(manager.current_streak_count).to eq 0
      end
    end
  end

  it "Records the check in" do
    expect { manager.check_in(check_in_type: "crushed") }
      .to change { habit.check_ins.where(check_in_type: "crushed").count }
      .by(1)
  end

  it "creates two check ins" do
    Timecop.freeze(1.day.ago) { manager.check_in(check_in_type: "crushed") }
    manager.check_in(check_in_type: "crushed")
    expect(habit.check_ins.where(check_in_type: "crushed").count).to eq 2
  end

  context "when checking in" do
    it "only has one running streak" do
      manager.check_in(check_in_type: "crushed")
      manager.check_in(check_in_type: "crushed")
      expect(habit.streaks.running.count).to eq 1
    end

    context "when there has never been a streak" do
      it "starts a streak" do
        manager.check_in(check_in_type: "crushed")
        expect(habit.streaks.running.count).to eq 1
      end
    end

    describe "counting days in a streak" do
      it "has been running for two days" do
        Timecop.freeze(2.days.ago) { manager.check_in(check_in_type: "crushed") }
        Timecop.freeze(1.days.ago) { manager.check_in(check_in_type: "crushed") }
        expect(manager.current_streak_count).to eq 2
      end

      it "has been running for three days" do
        Timecop.freeze(3.days.ago) { manager.check_in(check_in_type: "crushed") }
        Timecop.freeze(2.days.ago) { manager.check_in(check_in_type: "crushed") }
        Timecop.freeze(1.days.ago) { manager.check_in(check_in_type: "crushed") }
        expect(manager.current_streak_count).to eq 3
      end

      context "when missing a day" do
        it "has been running for zero days" do
          Timecop.freeze(3.days.ago) { manager.check_in(check_in_type: "crushed") }
          Timecop.freeze(2.days.ago) { manager.check_in(check_in_type: "crushed") }
          expect(manager.current_streak_count).to eq 0
        end

        it "has been running for one day" do
          Timecop.freeze(3.days.ago) { manager.check_in(check_in_type: "crushed") }
          Timecop.freeze(1.days.ago) { manager.check_in(check_in_type: "crushed") }
          expect(manager.current_streak_count).to eq 1
        end

        it "has been running for three days" do
          Timecop.freeze(8.days.ago) { manager.check_in(check_in_type: "crushed") }
          Timecop.freeze(7.days.ago) { manager.check_in(check_in_type: "crushed") }
          Timecop.freeze(6.days.ago) { manager.check_in(check_in_type: "crushed") }
          Timecop.freeze(5.days.ago) { manager.check_in(check_in_type: "crushed") }
          Timecop.freeze(3.days.ago) { manager.check_in(check_in_type: "crushed") }
          Timecop.freeze(2.days.ago) { manager.check_in(check_in_type: "crushed") }
          Timecop.freeze(1.days.ago) { manager.check_in(check_in_type: "crushed") }
          expect(manager.current_streak_count).to eq 3
        end
      end

      context "when missing three days" do
        it "has been running for one day" do
          Timecop.freeze(5.days.ago) { manager.check_in(check_in_type: "crushed") }
          Timecop.freeze(1.days.ago) { manager.check_in(check_in_type: "crushed") }
          expect(manager.current_streak_count).to eq 1
        end

        it "has been running for two days" do
          Timecop.freeze(7.days.ago) { manager.check_in(check_in_type: "crushed") }
          Timecop.freeze(6.days.ago) { manager.check_in(check_in_type: "crushed") }
          Timecop.freeze(2.days.ago) { manager.check_in(check_in_type: "crushed") }
          Timecop.freeze(1.days.ago) { manager.check_in(check_in_type: "crushed") }
          expect(manager.current_streak_count).to eq 2
        end
      end
    end
  end
end
