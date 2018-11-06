require 'rails_helper'

RSpec.describe HabitsController do
  it "shows AR errors" do
    Habit.create(name: "Something to crush")
    visit habits_path
    find(".crushed").click
    find(".crushed").click
    expect(page).to have_content "error"
  end
end
