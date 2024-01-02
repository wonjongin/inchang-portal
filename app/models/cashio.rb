class Cashio < ApplicationRecord
  enum io: { input: 0, output: 1 }
  belongs_to :user

  def io_string
    return "입금" if self.io == "input"
    return "출금" if self.io == "output"
  end

  def wday_name
    %w[일 월 화 수 목 금 토][self.date.wday]
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

  def self.balance_by(date_string)
    total = Cashio
              .order(date: :asc)
              .order(id: :asc)
              .where(date: ..date_string)
              .sum(:price)
    total
  end

  def self.total
    total = Cashio.all.sum(:price)
    total
  end

  def self.total_day(date_string)
    total = Cashio.where(date: date_string).sum(:price)
    total
  end

  def self.total_day_input(date_string)
    total = Cashio.where(date: date_string, io: 'input').sum(:price)
    total
  end

  def self.total_day_output(date_string)
    total = Cashio.where(date: date_string, io: 'output').sum(:price)
    total
  end

  def self.summary_at(date_string)
    one_day = Cashio.order(date: :asc).order(id: :asc).where(date: date_string)

    {
      date: date_string.to_date,
      count: one_day.count,
      total_input: one_day.where(io: 'input').sum(:price),
      total_output: one_day.where(io: 'output').sum(:price),
      total_day: one_day.sum(:price),
      title: one_day.first.desc,
      balance: Cashio.balance_by(date_string),
    }
  end

  def self.all_day
    day_list = Cashio.order(date: :desc).pluck(:date).uniq
    all_day = []

    day_list.each do |date|
      all_day << Cashio.summary_at(date)
    end
    all_day
  end

  def start_time
    self.date
  end

  def self.admitted_icon_for_day(date)
    diaries = Cashio.where(date: date)
    admitted = true
    diaries.each do |cashio|
      unless cashio.admitted
        return '❌'
      end
    end
    '✅'
  end
end
