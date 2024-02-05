class CarFuel < ApplicationRecord
  enum fuel_type: { gasoline: 0, diesel: 1 }
  belongs_to :car
  belongs_to :user

  def wday_name
    %w[일 월 화 수 목 금 토][self.refueled_at.wday]
  end

  def fuel_type_kr
    d = {
      gasoline: '휘발유',
      diesel: '경유',
    }.stringify_keys!
    d[self.fuel_type]
  end

  def sub_odo
    prev = CarFuel.where(car_id: self.car_id).order(odo: :desc).where("odo < ?", self.odo).first
    if(prev.blank?)
      0
    else
      self.odo - prev.odo
    end
  end

  def amount
    (self.price / self.unit_price).floor(2)
  end

  def instant_mileage
    (self.sub_odo / self.amount).floor(2)
  end

  def self.total_fuel_amount(car)
    tot = 0
    recent = car.car_fuels.order(odo: :desc).first
    if recent.blank?
      return tot
    end
    all = car.car_fuels.where.not(id: recent.id)
    all.each do |fuel|
      tot += fuel.amount
    end
    tot
  end

  def self.average_mileage(car)
    recent =  car.car_fuels.order(odo: :asc).last
    if recent.blank?
      return 0
    end
    first = car.car_fuels.order(odo: :asc).first
  
    total_fuel_amount = CarFuel.total_fuel_amount(car)
    if total_fuel_amount == 0
      return 0
    end
    ((recent.odo - first.odo) / total_fuel_amount).floor(2)
  end
end
