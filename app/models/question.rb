class Question < ApplicationRecord
  validates :content, presence: true, length: { in: 2..50 }
  validates :user_id, presence: true

  belongs_to :user
  has_many :answers, dependent: :destroy
end
