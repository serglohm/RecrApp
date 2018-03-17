class Language < ApplicationRecord
  has_many :lang_skills
  has_many :candidates, through: :lang_skills
  has_many :lang_requirements
  has_many :vacancies, through: :lang_requirements
end
