class Company < ApplicationRecord
  has_many :vacancies

  validates :name, presence: true, uniqueness: true
end
