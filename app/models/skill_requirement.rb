class SkillRequirement < ApplicationRecord
  belongs_to :vacancy
  belongs_to :language
end
