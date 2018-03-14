class Vacancy < ApplicationRecord
  belongs_to :company
  has_many :languages, as: :assignable
end
