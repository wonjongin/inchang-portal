class Api::V1::MeetingController < ApplicationController
  include AuthRequest
  before_action :current_user

  def list
    @filter = params[:filter]
    @filter = 'all' if @filter == nil
    if @filter == 'all'
      @meetings = Meeting.all
    else
      @meetings = Meeting.where(is_exterior: @filter)
    end
  end

  def detail
    @meeting = Meeting.find_by(id: params[:meeting_id])
  end

  def new
  end

  def create
    author = User.find_by(name: params[:user])
    puts("=====================#{params[:user]}, #{author}========")
    if author == nil
      render json: {
        status: :fail,
        code: :not_found_user,
        message: "There is no user of #{params[:author]}",
      } and return
    end
    m = Meeting.create(
      at: params[:at],
      user: author,
      title: params[:title],
      is_exterior: params[:is_exterior],
      attendee: params[:attendee],
      description: params[:description],
      footnote: params[:footnote],
      admitted: 'admitted'
    )
    render json: {
      status: :ok,
      message: "Success!",
      code: :success,
      meeting_id: m.id,
    }
  end

  def edit
    @meeting = Meeting.find_by(id: params[:meeting_id])
  end

  def update
    author = User.find_by(name: params[:user])
    if author == nil
      render json: {
        status: :fail,
        code: :not_found_user,
        message: "There is no user of #{params[:author]}",
      } and return
    end
    m = Meeting.find_by(id: params[:meeting_id])
    m.update(
      at: params[:at],
      user: author,
      title: params[:title],
      is_exterior: params[:is_exterior],
      attendee: params[:attendee],
      description: params[:description],
      footnote: params[:footnote],
    )
    render json: {
      status: :ok,
      message: "Success!",
      code: :success,
      meeting_id: m.id,
    }
  end

  def delete
    if @current_user.is_admin?
      m = Meeting.find_by(id: params[:meeting_id])
      m.destroy!
      redirect_to "/api/v1/meeting/list"
    else
      flash.alert = "권한이 없어요"
      redirect_to "/api/v1/meeting/list"
    end
  end

  def admit
    m = Meeting.find_by(id: params[:id])
    if @current_user.is_admin?
      m.update(admitted: 'admitted')
    else
      flash.alert = "권한이 없어요"
    end
    redirect_to "/api/v1/meeting/detail/#{params[:id]}"
  end

  def de_admit
    m = Meeting.find_by(id: params[:id])
    if @current_user.is_admin?
      m.update(admitted: 'not')
    else
      flash.alert = "권한이 없어요"
    end
    redirect_to "/api/v1/meeting/detail/#{params[:id]}"
  end
end
