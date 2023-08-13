class User < ApplicationRecord
  has_many :diaries
  has_many :feedbacks


  def is_admin?
    self.permission == 'admin'
  end
end
