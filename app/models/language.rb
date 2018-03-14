class Language < ApplicationRecord
  belongs_to :assignable, polymorphic: true
end
