class Diary < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  # validates :id, uniqueness: true, presence: true

  def start_time
    self.date ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
  end
end
