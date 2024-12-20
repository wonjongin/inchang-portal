class CarLog < ApplicationRecord
  belongs_to :user
  belongs_to :car


  def sub_odo
    prev = CarLog.where(car_id: self.car_id).order(odo: :desc).where("odo < ?", self.odo).first
    if(prev.blank?)
      0
    else
      self.odo - prev.odo
    end
  end

  def wday_name
    %w[일 월 화 수 목 금 토][self.at.wday]
  end
end
