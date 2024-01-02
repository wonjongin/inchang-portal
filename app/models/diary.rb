class Diary < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  # validates :id, uniqueness: true, presence: true

  def start_time
    self.date ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
  end

  def wday_name
    %w[일 월 화 수 목 금 토][self.date.wday]
  end

  def admit_status_icon
    self.admitted ? '✅' : '❌'
  end

  def self.count_day_diaries(date)
    Diary.where(date: date).count
  end

  def self.day_list
    Diary.order(date: :desc).pluck(:date).uniq
  end

  def self.admitted_icon_for_day(date)
    diaries = Diary.where(date: date)
    admitted = true
    diaries.each do |diary|
      unless diary.admitted
        return '❌'
      end
    end
    '✅'
  end

  def self.feedbacks_count_day(date)
    count = 0
    Diary.where(date: date).each do |diary|
      count += diary.feedbacks.count
    end
    count
  end
end
