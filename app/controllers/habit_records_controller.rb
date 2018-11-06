class HabitRecordsController < ApplicationController
  def create
    HabitRecord.create(habit_id: params[:habit_id],
                       crushed_on: params[:crushed_on],
                       missed_on: params[:missed_on])
    redirect_to habits_path
  end

  private

  def habit_records_params
    params.require(:habit_record).permit(:crushed_on, :missed_on, :habit_id)
  end
end
