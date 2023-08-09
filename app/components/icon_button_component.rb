# frozen_string_literal: true

class IconButtonComponent < ViewComponent::Base
  def initialize(class_name:, path:, icon:)
    @class = class_name
    @path = path
    @icon = icon
  end

end
