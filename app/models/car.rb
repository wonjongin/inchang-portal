class Car < ApplicationRecord
  enum status: { use: 0, disposal: 1 }
  has_many :car_repairs
  has_many :car_fuels

  acts_as_xlsx
  def status_icon
    return '🟢' if self.status == 'use'
    '🔴' if self.status == 'disposal'
  end

  def status_ko_kr
    return '사용중' if self.status == 'use'
    '매각' if self.status == 'disposal'
  end

  def car_type
    first_number = self.number[0...-5].to_i
    type = ''
    if first_number < 70
      type = 'car'
    elsif first_number < 80
      type = 'van'
    elsif first_number < 98
      type = 'truck'
    elsif first_number < 100
      type = 'special'
    elsif first_number < 700
      type = 'car'
    elsif first_number < 800
      type = 'van'
    elsif first_number < 980
      type = 'truck'
    elsif first_number < 1000
      type = 'special'
    end

    type
  end

  def car_type_icon
    icon = ''
    if self.car_type == 'car'
      icon = '🚗'
    elsif self.car_type == 'van'
      icon = '🚐'
    elsif self.car_type == 'truck'
      icon = '🛻'
    elsif self.car_type == 'special'
      icon = '🚛'
    end

    icon
  end
end
