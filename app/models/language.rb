class Language < ApplicationRecord
  has_many :lang_skills
  has_many :candidates, through: :lang_skills
end
