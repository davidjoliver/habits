require 'rails_helper'

RSpec.describe Habit do
  describe "for current streak count" do
    context "when there is no current streak" do
      it "just returns zero" do
        expect(subject.current_streak_count).to eq 0
      end
    end
  end
end
