class VacationHistory < ApplicationRecord
  belongs_to :user

  enum vacation_type: { annual: 0, half_day: 1 }

  def vacation_type_kr
    return '??' if vacation_type.blank?

    d = {
      annual: '연차',
      half_day: '반차'
    }.stringify_keys!
    d[vacation_type]
  end

  def date_range
    return [] if start_date.nil? || end_date.nil?

    (start_date..end_date).map do |date|
      {
        date: date.strftime('%-m/%-d'),
        type: vacation_type_kr,
        reason: reason
      }
    end
  end
end
