class Book < ApplicationRecord
  belongs_to :author
  has_and_belongs_to_many :genres
  validates :title, presence: true, length: { in: 5..20 }
end
