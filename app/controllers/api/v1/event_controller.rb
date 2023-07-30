class Api::V1::EventController < ApplicationController
  include AuthRequest
  before_action :current_user
  def new
    @diary = Diary.find_by(id: params[:diary_id])
  end

  def create
    d = Diary.find_by(id: params[:diary_id])
    e = Event.create do |t|
      t.start_time = params[:start_time]
      t.end_time = params[:end_time]
      t.desc = params[:desc]
      t.diary = d
    end
    redirect_to "/api/v1/event/new/#{params[:diary_id]}"
  end

  def delete
    Event.find(params[:id]).destroy
    redirect_to "/api/v1/event/new/#{params[:diary_id]}"
  end

  def update
    e = Event.find_by(id: params[:id])
    e.update(
      start_time: params[:start_time],
      end_time: params[:end_time],
      desc: params[:desc]
    )

    # redirect_to "/api/v1/event/new/#{params[:diary_id]}"
  end
end
