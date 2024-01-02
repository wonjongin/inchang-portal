class Api::V1::FeedbackController < ApplicationController
  include AuthRequest
  before_action :current_user

  def new
  end

  def create
    d = Diary.find(params[:diary_id])
    f = Feedback.create(
      user: @current_user,
      diary: d,
      desc: params[:desc],
    )
    n = Notification.create(
      title: '피드백이 추가되었습니다.',
      desc: "#{@current_user.name}: #{params[:desc]}",
      icon: 'bell',
      read: false,
      about: 'diary',
      user: d.user,
      link: "/api/v1/diary/detail/#{d.id}"
    )
    redirect_to "/api/v1/detail/#{d.id}"
  end

  def update
    f = Feedback.find_by(id: params[:id])
    f.update(
      desc: params[:desc],
    )
    redirect_to "/api/v1/detail/#{params[:diary_id]}"
  end

  def delete
    d = Feedback.find_by(id: params[:id])
    unless d.user == @current_user
      render json: {
        status: :fail,
        code: :not_an_author,
        message: "You are not an author of the feedback",
      } and return
    end
    diary_id = d.diary.id
    d.destroy!
    render json: {
      status: :ok,
      code: :success,
      message: "Success!",
      diary_id: diary_id,
    }
  end
end
