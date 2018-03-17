class Vacancy < ApplicationRecord
  belongs_to :company
  has_many :lang_requirements
  has_many :languages, through: :lang_requirements
end
