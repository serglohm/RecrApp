class LangRequirement < ApplicationRecord
  belongs_to :vacancy
  belongs_to :language
end
