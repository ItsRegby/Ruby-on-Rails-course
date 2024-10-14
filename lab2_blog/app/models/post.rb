class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_rich_text :body

  validates :title, presence: true, uniqueness: true
  validates :body, presence: true, length: { minimum: 10 }

  belongs_to :category, optional: true
end
