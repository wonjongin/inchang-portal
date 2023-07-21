class User < ApplicationRecord
  has_many :diaries
  has_many :feedbacks
end
