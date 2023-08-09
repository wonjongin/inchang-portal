# frozen_string_literal: true

class BasicButtonComponent < ViewComponent::Base
  def initialize(class_name = "btn btn-primary", title:, path:)
    @title = title
    @path = path
    @class = class_name
  end

end
