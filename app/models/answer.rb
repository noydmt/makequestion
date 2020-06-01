class Answer < ApplicationRecord
  validates :content, length: { in: 1..150 }

  belongs_to :question
end
