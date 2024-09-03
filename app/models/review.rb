class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  validates :comment, length: { minimum: 4 }
  STARS = [1, 2, 3, 4, 5]
  validates :stars, inclusion: { in: STARS, message: "must be between 1 and 5" }

  def stars_as_percent
    (stars / 5.0) * 100.0
  end

  # Scope for fetching reviews written in the past n days
  scope :past_n_days, ->(days) { where("created_at >= ?", days.days.ago) }
end
