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
    add_events params[:desc], d
    fill_end_times d.id
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
    add_events params[:desc], d
    fill_end_times d.id
    render json: {
      status: :ok,
      message: "Success!",
      code: :success,
      diary_id: d.id,
    }
  end

  def list
    @title = '업무일지 목록' unless params[:type]
    @title = '나의 업무일지' if params[:type] == 'my'
    @title = '승인되지 않은 업무일지' if params[:type] == 'unadmitted'
    if params[:year] == nil || params[:month] == nil
      today = Date.today
      @year = today.year
      @month = today.month
    else
      @year = params[:year].to_i
      @month = params[:month].to_i
    end
    @next = next_or_priv(true, @year, @month)
    @priv = next_or_priv(false, @year, @month)
    @day_list = Diary.order(date: :desc).where(date: Date.civil(@year, @month, 1)..Date.civil(@year, @month, -1))
                     .pluck(:date).uniq!
    @day_list = [] if @day_list == nil
  end

  def calendar
    start_date = params.fetch(:start_date, Date.today).to_date
    @holidays = JSON.parse(File.read(File.join('app/assets/data', 'holidays.json')))
    @diaries = Diary.all.where(date: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week).order(date: :desc)
  end

  def admit
    d = Diary.find_by(id: params[:id])
    d.update(admitted: true) if @current_user.is_admin?
    redirect_to "/api/v1/diary/detail/#{params[:id]}"
  end

  def de_admit
    d = Diary.find_by(id: params[:id])
    d.update(admitted: false) if @current_user.is_admin?
    redirect_to "/api/v1/diary/detail/#{params[:id]}"
  end

  def search
    if params[:q].blank?
      return
    else
      @query = params[:q]
      @sd = Diary.order(date: :desc).joins(:events).where("desc LIKE ?", "%" + @query + "%").uniq

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

  def day
    @date = params[:date]
    @diaries = Diary.where(date: @date)
  end

  def back_up
    unless @current_user.is_admin?
      redirect_to '/api/v1/diary/list' and return
    end
    data = {
      diaries: Diary.all,
      events: Event.all,
      feedbacks: Feedback.all,
      users: User.all,
      cashio: Cashio.all,
    }
    send_data data.to_json, type: 'application/json; header=present', disposition: "attachment; filename=#{Date.today.to_s}.json"
  end

  private

  def next_or_priv(is_next, year, month)
    if is_next
      if month == 12
        [year + 1, 1].join('/')
      else
        [year, month + 1].join('/')
      end
    else
      if month == 1
        [year - 1, 12].join('/')
      else
        [year, month - 1].join('/')
      end
    end
  end

  def add_events(data, d)
    rows = data
    rows.each do |row|
      start_time = DateTime.new(
        d.date.year,
        d.date.month,
        d.date.day,
        row[:start_time].gsub(" ", "").split(':')[0].to_i,
        row[:start_time].gsub(" ", "").split(':')[1].to_i, 0
      ).strftime('%F %T')
      end_time = nil
      end_time = DateTime.new(
        d.date.year,
        d.date.month,
        d.date.day,
        row[:end_time].gsub(" ", "").split(':')[0].to_i,
        row[:end_time].gsub(" ", "").split(':')[1].to_i, 0
      ).strftime('%F %T') if row[:end_time] != ""
      e = Event.create do |t|
        t.start_time = start_time
        t.end_time = end_time
        t.desc = row[:content]
        t.diary = d
      end
    end
  end

  def fill_end_times(diary_id)
    diary = Diary.find_by(id: diary_id)
    events = diary.events.order(start_time: :asc)
    start_times = []
    events.each do |event|
      start_times << event.start_time
    end
    events.each_with_index do |event, index|
      unless event.end_time
        event.end_time = start_times[index + 1]
        event.save!
      end
    end
  end
end
