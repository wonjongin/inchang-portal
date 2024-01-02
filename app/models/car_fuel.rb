class CarFuel < ApplicationRecord
  belongs_to :car
  belongs_to :user

  def wday_name
    %w[일 월 화 수 목 금 토][self.refueled_at.wday]
  end
end
