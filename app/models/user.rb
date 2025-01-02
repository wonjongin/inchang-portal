class User < ApplicationRecord
  has_many :diaries
  has_many :feedbacks
  has_many :notifications
  has_many :car_repairs
  has_many :car_logs
  has_many :car_fuels
  has_many :meetings

  enum status: { employed: 1, resigned: 2 }

  def is_admin?
    permission == 'admin'
  end

  def status_kr
    return '' if status.blank?

    d = {
      employed: '재직',
      resigned: '퇴사'
    }.stringify_keys!
    d[status]
  end
end
