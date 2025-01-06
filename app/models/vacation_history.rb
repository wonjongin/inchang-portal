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

  def vacation_type_kr_short
    return '??' if vacation_type.blank?

    d = {
      annual: '연',
      half_day: '반'
    }.stringify_keys!
    d[vacation_type]
  end

  def date_range
    return [] if start_date.nil? || end_date.nil?

    (start_date..end_date).map do |date|
      {
        id: id,
        date: date,
        type: vacation_type_kr_short,
        reason: reason,
        is_approved: is_approved
      }
    end
  end

  def total_days
    (end_date - start_date).to_i + 1
  end

  def approve_icon
    return '❌' unless is_approved

    '✅'
  end
end
