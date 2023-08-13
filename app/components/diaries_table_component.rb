# frozen_string_literal: true

class DiariesTableComponent < ViewComponent::Base
  def initialize(diaries:)
    @diaries = diaries
  end

end
