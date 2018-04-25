class Assignment < ApplicationRecord
  belongs_to :candidate
  belongs_to :vacancy
  has_many :events, dependent: :destroy
end
