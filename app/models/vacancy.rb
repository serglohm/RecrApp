class Vacancy < ApplicationRecord
  belongs_to :company
  has_many :lang_requirements
  has_many :languages, through: :lang_requirements

  has_many :assignments
  has_many :candidates, through: :assignments
end
