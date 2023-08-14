class Api::V1::DiaryController < ApplicationController
  include AuthRequest
  before_action :current_user

  def new
    @preset_date = params[:date] if params[:date]
    @preset_date = Date.today unless params[:date]
    render 'api/v1/diary/one_new'
  end

  def edit
    @diary = Diary.find_by(id: params[:id])
    @desc = ""
    @diary.events.order(start_time: :asc).each do |event|
      @desc << "#{event.start_time.strftime('%H:%M')} #{event.desc}\n"
    end
    render 'api/v1/diary/one_edit'
  end

  def create
    d = Diary.create do |t|
      t.date = params[:date]
      t.user = params[:author]
      t.admitted = false
    end
    redirect_to "/api/v1/event/new/#{d.id}"
  end

  def create2
    author = User.find_by(name: params[:author])
    if author == nil
      render json: {
        status: :fail,
        code: :not_found_user,
        message: "There is no user of #{params[:author]}",
      } and return
    end
    d = Diary.create do |t|
      t.date = params[:date]
      t.user = author
      t.admitted = false
    end

    rows = params[:desc].split("\n")
    rows.each do |row|
      cols = row.split(" ", 2)
      puts "#{cols}"
      start_time = DateTime.new(
        d.date.year,
        d.date.month,
        d.date.day,
        cols[0].gsub(" ", "").split(':')[0].to_i,
        cols[0].gsub(" ", "").split(':')[1].to_i, 0
      ).strftime('%F %T')
      # end_time = DateTime.new(
      #   d.date.year, 
      #   d.date.month, 
      #   d.date.day, 
      #   cols[1].gsub(" ", "").split(':')[0].to_i, 
      #   cols[1].gsub(" ", "").split(':')[1].to_i, 0
      # ).strftime('%F %T')
      e = Event.create do |t|
        t.start_time = start_time
        t.end_time = nil
        t.desc = cols[1]
        t.diary = d
      end
    end
    render json: {
      status: :ok,
      message: "Success!",
      code: :success,
      diary_id: d.id,
    }
  end

  def create3
    author = User.find_by(name: params[:author])
    if author == nil
      render json: {
        status: :fail,
        code: :not_found_user,
        message: "There is no user of #{params[:author]}",
      } and return
    end
    d = Diary.create do |t|
      t.date = params[:date]
      t.user = author
      t.admitted = false
    end

    rows = params[:desc]
    rows.each do |row|
      start_time = DateTime.new(
        d.date.year,
        d.date.month,
        d.date.day,
        row[:time].gsub(" ", "").split(':')[0].to_i,
        row[:time].gsub(" ", "").split(':')[1].to_i, 0
      ).strftime('%F %T')
      # end_time = DateTime.new(
      #   d.date.year,
      #   d.date.month,
      #   d.date.day,
      #   cols[1].gsub(" ", "").split(':')[0].to_i,
      #   cols[1].gsub(" ", "").split(':')[1].to_i, 0
      # ).strftime('%F %T')
      e = Event.create do |t|
        t.start_time = start_time
        t.end_time = nil
        t.desc = row[:content]
        t.diary = d
      end
    end
    render json: {
      status: :ok,
      message: "Success!",
      code: :success,
      diary_id: d.id,
    }
  end

  def update3
    d = Diary.find_by(id: params[:id])
    author = User.find_by(name: params[:author])
    if author == nil
      render json: {
        status: :fail,
        code: :not_found_user,
        message: "There is no user of #{params[:author]}",
      } and return
    end
    d.update(date: params[:date], user: author)
    Event.where(diary: d).destroy_all
    rows = params[:desc]
    rows.each do |row|
      start_time = DateTime.new(
        d.date.year,
        d.date.month,
        d.date.day,
        row[:time].gsub(" ", "").split(':')[0].to_i,
        row[:time].gsub(" ", "").split(':')[1].to_i, 0
      ).strftime('%F %T')
      # end_time = DateTime.new(
      #   d.date.year,
      #   d.date.month,
      #   d.date.day,
      #   cols[1].gsub(" ", "").split(':')[0].to_i,
      #   cols[1].gsub(" ", "").split(':')[1].to_i, 0
      # ).strftime('%F %T')
      e = Event.create do |t|
        t.start_time = start_time
        t.end_time = nil
        t.desc = row[:content]
        t.diary = d
      end
    end

    render json: {
      status: :ok,
      message: "Success!",
      code: :success,
      diary_id: d.id,
    }
  end

  def update
    d = Diary.find_by(id: params[:id])
    author = User.find_by(name: params[:author])
    if author == nil
      render json: {
        status: :fail,
        code: :not_found_user,
        message: "There is no user of #{params[:author]}",
      } and return
    end
    d.update(date: params[:date], user: author)
    Event.where(diary: d).destroy_all
    rows = params[:desc].gsub("\n\n", "").split("\n")
    rows.each do |row|
      cols = row.split(" ", 2)
      puts "#{cols}"
      start_time = DateTime.new(
        d.date.year,
        d.date.month,
        d.date.day,
        cols[0].gsub(" ", "").split(':')[0].to_i,
        cols[0].gsub(" ", "").split(':')[1].to_i, 0
      ).strftime('%F %T')
      # end_time = DateTime.new(
      #   d.date.year, 
      #   d.date.month, 
      #   d.date.day, 
      #   cols[1].gsub(" ", "").split(':')[0].to_i, 
      #   cols[1].gsub(" ", "").split(':')[1].to_i, 0
      # ).strftime('%F %T')
      e = Event.create do |t|
        t.start_time = start_time
        t.end_time = nil
        t.desc = cols[1]
        t.diary = d
      end
    end

    render json: {
      status: :ok,
      message: "Success!",
      code: :success,
    }
  end

  def list
    @now_page = params[:page] if params[:page]
    @now_page = 1 unless params[:page]
    @title = '업무일지 목록' unless params[:type]
    @title = '나의 업무일지' if params[:type] == 'my'
    @title = '승인되지 않은 업무일지' if params[:type] == 'unadmitted'
    @diaries = Diary.all.order(date: :desc).page(@now_page).per(50) unless params[:type]
    @diaries = Diary.all
                    .where(user: @current_user)
                    .order(date: :desc)
                    .page(@now_page)
                    .per(10) if params[:type] == 'my'
    @diaries = Diary.all
                    .where(admitted: false)
                    .order(date: :desc)
                    .page(@now_page)
                    .per(10) if params[:type] == 'unadmitted'
  end

  def list_my_diaries
    @diaries = Diary.all.where(user: @current_user).order(date: :desc)
  end

  def list_of_unadmitted
    @diaries = Diary.all.where(admitted: false).order(date: :desc)
  end

  def my_diaries
    @diaries = @current_user.diaries
    render '/api/v1/diary/list'
  end

  def calendar
    start_date = params.fetch(:start_date, Date.today).to_date
    @diaries = Diary.all.where(date: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week).order(date: :desc)
  end

  def admit
    d = Diary.find_by(id: params[:id])
    d.update(admitted: true) if @current_user.is_admin?
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
      render '/api/v1/diary/search'
    end
  end

  def delete
    if @current_user.is_admin?
      @d = Diary.find_by(id: params[:id])
      @d.destroy!
      redirect_to "/api/v1/diary/list"
    else
      flash.alert = "권한이 없어요"
      redirect_to "/api/v1/diary/detail/#{params[:id]}"
    end
  end

  # def pdf_template
  #   @diary = Diary.find_by(id: params[:id])
  # end

  def make_pdf
    @diary = Diary.find_by(id: params[:id])

    # respond_to do |format|
    #   format.html
    #   format.pdf do
    #     @html = ActionController.Base.new.render_to_string(
    #       template: 'api/v1/diary/make_pdf',
    #       formats: [:html],
    #       orientation: "Landscape",
    #       page_size: 'A4',
    #     )
    #     @pdf = WickedPdf.new.pdf_from_string(@html)
    #     send_data(@pdf, filename:"업무일지 #{@diary.user.name} #{@diary.date}", type: 'application/pdf', disposition: 'attachment')
    #   end
    # end

    @html = render_to_string(
      template: 'api/v1/diary/make_pdf',
      formats: [:html],
      layout: 'pdf',
      orientation: "Landscape",
      page_size: 'A4',
      encoding: "UTF-8"
    )
    @pdf = WickedPdf.new.pdf_from_string(@html)
    send_data @pdf, file_name: "업무일지 #{@diary.user.name} #{@diary.date}.pdf", disposition: 'inline'

    # respond_to do |format|
    #   format.html
    #   format.pdf do
    #     render pdf: "업무일지 #{@diary.user.name} #{@diary.date}",
    #            page_size: 'A4',
    #            template: 'api/v1/diary/make_pdf',
    #            formats: [:html],
    #            layout: 'pdf',
    #            orientation: "Landscape",
    #            disposition: 'inline',
    #            zoom: 1,
    #            dpi: 150
    #   end
    # end
  end

  def detail
    @diary = Diary.find_by(id: params[:id])
  end

  def back_up
    data = [Diary.all, Event.all, Feedback.all, User.all]
    send_data data.to_json, type: 'application/json; header=present', disposition: "attachment; filename=backup.json"
  end
end
