class Api::V1::FeedbackController < ApplicationController
  include AuthRequest
  before_action :current_user

  def new
  end

  def create
    f = Feedback.create(
      user: @current_user,
      diary: Diary.find(params[:diary_id]),
      desc: params[:desc],
    )
    redirect_to "/api/v1/detail/#{params[:diary_id]}"
  end

  def update
    f = Feedback.find_by(id: params[:id])
    f.update(
      desc: params[:desc],
    )
    redirect_to "/api/v1/detail/#{params[:diary_id]}"
  end
end
