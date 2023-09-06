# frozen_string_literal: true

class HeaderComponent < ViewComponent::Base
  def initialize(current_user:)
    @current_user = current_user
    @unread_noti_count = Notification.where(read: false, user: @current_user).count
    @limit = 10
  end

end
