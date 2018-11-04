class HabitsController < ApplicationController
  def new
    @habit = Habit.new
  end

  def create
    Habit.create(habit_params)
    redirect_to root_path
  end

  def index
    @habits = Habit.all
    @today_date = Date.today.strftime("%Y-%m-%d")
  end

  private

  def habit_params
    params.require(:habit).permit(:name, :habit_type)
  end
end
