# frozen_string_literal: true

class DiariesTableComponent < ViewComponent::Base
  def initialize(diaries:)
    @diaries = diaries
    @weekdays = ['일', '월', '화', '수', '목', '금', '토']
  end

end
