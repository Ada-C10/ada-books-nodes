class Book < ApplicationRecord
  belongs_to :author
  has_and_belongs_to_many :genres

  validates :title, presence: true, length: { in: 5..100 }
  validates :title, uniqueness: true
end
