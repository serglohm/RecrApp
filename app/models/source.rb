class Source < ApplicationRecord
  has_many :candidates
  validates :name, presence: true
end
