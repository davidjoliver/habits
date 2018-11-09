class Streak < ApplicationRecord
  belongs_to :habit

  def self.running
    self.where.not(start_date: nil).where(end_date: nil)
  end
end