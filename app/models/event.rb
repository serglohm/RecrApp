class Event < ApplicationRecord
  belongs_to :assignment, optional: true
  validates :name, presence: true
  validates :scheduled_on, presence: true
  validates :status, presence: true

  enum status: [:active, :done, :cancelled]

  scope :upcoming, -> { where("scheduled_on < ?", Date.today + 7.days) }
end
