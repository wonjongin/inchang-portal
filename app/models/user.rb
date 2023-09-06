class User < ApplicationRecord
  has_many :diaries
  has_many :feedbacks
  has_many :notifications

  def is_admin?
    self.permission == 'admin'
  end
end
