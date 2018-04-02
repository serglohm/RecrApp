class Vacancy < ApplicationRecord
  belongs_to :company
  has_many :skill_requirements, dependent: :destroy
  has_many :skills, through: :skill_requirements

  has_many :assignments, dependent: :destroy
  has_many :candidates, through: :assignments
end
