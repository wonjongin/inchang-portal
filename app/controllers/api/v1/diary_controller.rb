class Api::V1::DiaryController < ApplicationController
  include AuthRequest
  before_action :current_user

  def new
  end

  def create
    d = Diary.create do |t|
      t.date = params[:date]
      t.user = @current_user
      t.admitted = false
    end
    redirect_to "/api/v1/event/new/#{d.id}"
  end

  def list
    @diaries = Diary.all.order(date: :desc)
  end

  def my_diaries
    @diaries = @current_user.diaries
    render 'api/v1/diary/list'
  end

  def admit
    d = Diary.find_by(id: params[:id])
    d.update(admitted: true)
    redirect_to "/api/v1/diary/detail/#{params[:id]}"
  end

  # def search_page
  #   render 'api/v1/diary/search'
  # end

  def search
    if params[:q].blank?
      return
    else
      @query = params[:q]
      @sd = Diary.joins(:events).where("desc LIKE ?", "%" + @query + "%")
      render 'api/v1/diary/search'
    end
  end

  def detail
    @diary = Diary.find_by(id: params[:id])
  end
end
