module AuthRequest
  extend ActiveSupport::Concern

  def current_user
    @current_user = nil
    u = User.find_by(id: session[:user_id])
    @current_user ||= u

    redirect_to '/api/v1/login' unless @current_user

  end
end