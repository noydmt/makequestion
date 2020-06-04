class User < ApplicationRecord
  before_create :set_id

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :questions
  has_many :emails

  private
    def set_id
      while self.id.blank? || User.find_by(id: self.id).present? do
        self.id = SecureRandom.random_number(1 << 64)
      end
    end
end
