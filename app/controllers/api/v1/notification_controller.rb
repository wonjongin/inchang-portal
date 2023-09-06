class Api::V1::NotificationController < ApplicationController
  include AuthRequest
  before_action :current_user

  def list
    @limit = 100
  end

  def open
    noti = Notification.find_by(id: params[:id])
    noti.update(read: true)
    redirect_to noti.link
  end
end
