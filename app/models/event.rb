class Event < ApplicationRecord
  belongs_to :assignment, optional: true
  validates :name, presence: true
end
