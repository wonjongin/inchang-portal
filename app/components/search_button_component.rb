# frozen_string_literal: true

class SearchButtonComponent < ViewComponent::Base
  def initialize(url:, value:)
    @url = url
    @value = value
  end

end
