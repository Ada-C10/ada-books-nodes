class Book < ApplicationRecord
  belongs_to :author

  validates :title, presence: true, length: { in: 5..20 }
end
