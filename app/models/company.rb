class Company < ApplicationRecord
  has_many :vacancies
  has_many :candidates, through: :vacancies
  has_many :assignments, through: :vacancies

  validates :name, presence: true, uniqueness: true

  enum pay_type: [:gross_salary, :rate, :half_gross_salary]
end
