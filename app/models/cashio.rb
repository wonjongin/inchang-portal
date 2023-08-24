class Cashio < ApplicationRecord
  enum io: {input: 0, output: 1}
  belongs_to :user



  def io_string
    return "입금" if self.io == "input"
    return "출금" if self.io == "output"
  end

  def wday_name
    ['일', '월', '화', '수', '목', '금', '토'][self.date.wday]
  end

  def balance
    privious_total = Cashio
                      .order(date: :asc)
                      .order(id: :asc)
                      .where(date: ..self.date)
                      .where.not(date: self.date)
                      .sum(:price)
    today_total = 0
    today_data = Cashio
                   .order(date: :asc)
                   .order(id: :asc)
                   .where(date: self.date)
    today_data.each do |cashio|
      today_total += cashio.price
      if cashio == self
        break
      end
    end
    privious_total + today_total
  end

  def self.has_base_balance?
    if Cashio.exists?(is_base_balance: true)
      true
    else
      false
    end
  end

  def self.total
    total = Cashio.all.sum(:price)
    total
  end
end
