# frozen_string_literal: true

class BasicButtonComponent < ViewComponent::Base
  def initialize(title:, path:)
    @title = title
    @path = path
  end

end
