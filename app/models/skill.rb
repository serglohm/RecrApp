class Skill < ApplicationRecord
  has_many :skills_abilities
  has_many :candidates, through: :skills_abilities
  has_many :skills_requirements
  has_many :vacancies, through: :skills_requirements
end
