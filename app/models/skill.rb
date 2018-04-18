class Skill < ApplicationRecord
  has_many :skill_abilities, dependent: :destroy
  has_many :candidates, through: :skill_abilities
  has_many :skill_requirements, dependent: :destroy
  has_many :vacancies, through: :skill_requirements

  validates :name, presence: true, uniqueness: true
end
