class HabitRecordsController < ApplicationController
  def create
    @record = HabitRecord.create(habit_id: params[:habit_id],
                       checked_in_on: params[:checked_in_on],
                       check_in_type: params[:check_in_type])
    redirect_to habits_path, notice: @record.errors
  end

  private

  def habit_records_params
    params.require(:habit_record).permit(:crushed_on, :missed_on, :habit_id)
  end
end
