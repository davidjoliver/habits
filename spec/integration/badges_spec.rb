require 'rails_helper'

RSpec.describe StreakManager do
  let(:habit) { Habit.create(name: "a habit") }
  let(:manager) { StreakManager.new(habit: habit) }

  describe "the first badge" do
    it "triggers a badge" do
      expect { manager.check_in(check_in_type: "crushed") }.to change { Badge.count }.by 1
    end

    context "when it's your second check in" do
      it "doesn't trigger any badge" do
        Timecop.freeze(2.days.ago) { manager.check_in(check_in_type: "crushed") }
        expect { manager.check_in(check_in_type: "crushed") }.to_not change { Badge.count }
      end
    end
  end
end
