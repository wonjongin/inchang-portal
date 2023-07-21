class Diary < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  # validates :id, uniqueness: true, presence: true
end
