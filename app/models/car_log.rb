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
end
