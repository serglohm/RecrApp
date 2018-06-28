class Company < ApplicationRecord
  has_many :vacancies
  has_many :candidates, through: :vacancies
  has_many :assignments, through: :vacancies

  validates :name, presence: true, uniqueness: true

  enum pay_type: [:gross_salary, :rate, :half_gross_salary]

  def get_multiplier
    if self.rate?
      multiplier = (self.rate/100).to_f
    elsif self.half_gross_salary?
      multiplier = 1/24.0
    elsif self.gross_salary?
      multiplier = 1/12.0
    end
  end

  def get_rejects
    self.assignments.rejected
  end
end
