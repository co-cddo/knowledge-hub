class Comment < ApplicationRecord
  belongs_to :item
  validates :body, presence: true
end
