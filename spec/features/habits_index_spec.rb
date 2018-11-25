require 'rails_helper'

RSpec.describe HabitsController do
  it "shows checked in errors" do
    habit = Habit.create(name: "Something to crush")
    visit habits_path

    within("#habit#{habit.id}") do
      all(".check-in").first.click
    end

    within("#habit#{habit.id}") do
      all(".check-in").first.click
    end
    expect(page).to have_content "can only be done once per day"
  end

  it "shows a counter of days in habit" do
    habit = Habit.create(name: "Something to crush")
    Timecop.freeze(1.day.ago) do
      visit habits_path

      within("#habit#{habit.id}") do
        all(".check-in").first.click
      end
    end

    Timecop.freeze(Date.today) do
      visit habits_path

      within("#habit#{habit.id}") do
        all(".check-in").first.click
      end
    end

    expect(page).to have_content("2 days")
  end

  it "shows a badge" do
    habit = Habit.create(name: "Something to crush")
    Timecop.freeze(1.day.ago) do
      visit habits_path

      within("#habit#{habit.id}") do
        all(".check-in").first.click
      end
    end

    expect(page).to have_content("You crushed")
  end
end
