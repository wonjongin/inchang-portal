# frozen_string_literal: true

class SubmitButtonComponent < ViewComponent::Base
  def initialize(value:, form:)
    @value = value
    @form = form
  end

end
