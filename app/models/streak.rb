class Streak < ApplicationRecord
  belongs_to :habit
  validates :start_date, presence: true

  def self.running
    self.where(end_date: nil)
  end

  def self.currently_running
    running.first
  end
end
