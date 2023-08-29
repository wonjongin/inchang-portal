# frozen_string_literal: true

class DiariesTableComponent < ViewComponent::Base
  def initialize(dates:)
    @dates = dates
  end

end
