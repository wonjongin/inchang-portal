class Api::V1::EventController < ApplicationController
  include AuthRequest
  before_action :current_user
  def new
    @diary = Diary.find_by(id: params[:diary_id])
  end

  def create
    d = Diary.find_by(id: params[:diary_id])
    # start_time = DateTime.parse("#{d.date.strftime('%F')} #{params[:start_time]}:00").strftime('%Q')
    # end_time = DateTime.parse("#{d.date.strftime('%F')} #{params[:end_time]}:00").strftime('%Q')
    begin
      start_time = DateTime.new(d.date.year, d.date.month, d.date.day, params[:start_time].split(':')[0].to_i, params[:start_time].split(':')[1].to_i, 0).strftime('%F %T')
      end_time = DateTime.new(d.date.year, d.date.month, d.date.day, params[:end_time].split(':')[0].to_i, params[:end_time].split(':')[1].to_i, 0).strftime('%F %T')
    rescue
      render html: '<h1>시간 입력 형식이 잘못됨</h1>'
    else
      e = Event.create do |t|
        t.start_time = start_time
        t.end_time = end_time
        t.desc = params[:desc]
        t.diary = d
      end
      redirect_to "/api/v1/event/new/#{params[:diary_id]}", turbolinks: false
    end
  end

  def delete
    Event.find(params[:id]).destroy
    render json: {}
    # redirect_to controller: 'api/v1/event', action: 'new', id: params[:diary_id]
    # redirect_to "/api/v1/event/new/#{params[:diary_id]}"
  end

  def update
    begin
      d = Diary.find_by(id: params[:diary_id])
      start_time = DateTime.new(d.date.year, d.date.month, d.date.day, params[:start_time].split(':')[0].to_i, params[:start_time].split(':')[1].to_i, 0).strftime('%F %T')
      end_time = DateTime.new(d.date.year, d.date.month, d.date.day, params[:end_time].split(':')[0].to_i, params[:end_time].split(':')[1].to_i, 0).strftime('%F %T')
    rescue
      render html: '<h1>시간 입력 형식이 잘못됨</h1>'
    else
      e = Event.find_by(id: params[:id])
      e.update(
        start_time: start_time,
        end_time: end_time,
        desc: params[:desc]
      )
    end
    # redirect_to "/api/v1/event/new/#{params[:diary_id]}"
  end
end
