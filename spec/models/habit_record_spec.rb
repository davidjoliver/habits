require 'rails_helper'

RSpec.describe HabitRecord do
  it "does not allow checking in multiple times on the same day" do
    today = DateTime.new
    also_today = today + 1.hour
    valid = HabitRecord.create(checked_in_on: today)
    invalid = HabitRecord.create(checked_in_on: also_today)
    expect(valid).to be_valid
    expect(invalid).to_not be_valid
  end
end
