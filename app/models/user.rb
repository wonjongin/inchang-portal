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

  # 해당하는 해의 발생연차를 계산
  # @param year [Integer] 연차를 계산할 해
  # @return [Integer] 발생연차 수
  def total_vacations_in(year)
    experience = year - hire_date.year

    if experience >= 2
      [15 + (experience - 1).div(2), 25].min
    elsif experience == 1
      temp1 = hire_date.next_year
      temp2 = hire_date.next_year.end_of_year

      hire_date.month - 1 + (((temp2 - temp1) / 365) * 15).round
    elsif experience == 0
      12 - hire_date.month
    end
  end

  def total_vacations_in_this_year
    total_vacations_in(Date.today.year)
  end
end
