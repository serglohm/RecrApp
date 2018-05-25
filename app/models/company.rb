class Company < ApplicationRecord
  has_many :vacancies
  has_many :candidates, through: :vacancies
  validates :name, presence: true, uniqueness: true
end
