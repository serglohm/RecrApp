class Event < ApplicationRecord
  belongs_to :assignment, optional: true

  has_one :user, through: :assignment
  has_one :vacancy, through: :assignment
  has_one :company, through: :vacancy
  has_one :candidate, through: :assignment

  validates :name, presence: true
  validates :scheduled_on, presence: true
  validates :status, presence: true

  enum status: [:active, :done, :cancelled]

  scope :upcoming, -> { where("scheduled_on < ?", Date.today + 7.days) }
end
