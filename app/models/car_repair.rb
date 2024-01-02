class CarRepair < ApplicationRecord
  belongs_to :car
  belongs_to :user

  def wday_name
    %w[일 월 화 수 목 금 토][self.repaired_at.wday]
  end
end
