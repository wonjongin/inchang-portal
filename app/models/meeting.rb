class Meeting < ApplicationRecord
  enum admitted: { not: 0, admitted: 1 }
  belongs_to :user

  def wday_name
    %w[일 월 화 수 목 금 토][self.at.wday]
  end

  def type_ko_kr
    if self.is_exterior == 'interior'
      '내부'
    elsif self.is_exterior == 'exterior'
      '외부'
    end
  end

  def desc_html
    self.description.gsub!(/\n/, '<br/>').html_safe
  end

  def admit_status_icon
    self.admitted == 'admitted' ? '✅' : '❌'
  end

end

