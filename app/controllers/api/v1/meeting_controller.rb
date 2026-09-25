class Api::V1::MeetingController < ApplicationController
  include AuthRequest
  before_action :current_user

  def list
    @filter = params[:filter]
    @filter = 'all' if @filter == nil
    if params[:year].nil? || params[:month].nil?
      today = Date.today
      @year = today.year
      @month = today.month
    else
      @year = params[:year].to_i
      @month = params[:month].to_i
    end
    @next = next_or_priv(true, @year, @month)
    @priv = next_or_priv(false, @year, @month)
    @meetings = Meeting.where(at: Date.civil(@year, @month, 1)..Date.civil(@year, @month, -1))
    @meetings = @meetings.where(is_exterior: @filter) unless @filter == 'all'
    @meetings = @meetings.order(at: :desc)
  end

  def detail
    @meeting = Meeting.find_by(id: params[:meeting_id])
  end

  def new
  end

  def create
    author = User.find_by(name: params[:user])
    if author == nil
      render json: {
        status: :fail,
        code: :not_found_user,
        message: "There is no user of #{params[:author]}",
      } and return
    end
    m = Meeting.create(
      user: author,
      admitted: 'not',
    )
    m.update(
      params.require(:meeting).permit(:at, :title, :is_exterior, :attendee, :description, images: [])
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
    m.update(user: author)
    m.update(
      params.require(:meeting).permit(:at, :title, :is_exterior, :attendee, :description)
    )
    m.images.attach(params[:meeting][:images])
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

  def delete_image
    m = Meeting.find_by(id: params[:meeting_id])
    img = m.images.each do |img|
      img.purge if img.signed_id == params[:image_id]
    end

    redirect_to "/api/v1/meeting/detail/#{params[:meeting_id]}"
  end

  private

  def next_or_priv(is_next, year, month)
    if is_next
      if month == 12
        [year + 1, 1].join('/')
      else
        [year, month + 1].join('/')
      end
    elsif month == 1
      [year - 1, 12].join('/')
    else
      [year, month - 1].join('/')
    end
  end
end
