class User < ApplicationRecord
  has_many :diaries
  has_many :feedbacks
  has_many :notifications
  has_many :car_repairs
  has_many :car_fuels

  def is_admin?
    self.permission == 'admin'
  end
end
