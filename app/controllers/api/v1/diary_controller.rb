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
    render '/api/v1/diary/list'
  end

  def admit
    d = Diary.find_by(id: params[:id])
    d.update(admitted: true) if @current_user.permission == 'admin'
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
    if @current_user.permission == 'admin'
      @d = Diary.find_by(id: params[:id])
      @d.destroy!
      flash.alert = "업무일지를 삭제했어요?"
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
    send_data @pdf, file_name:  "업무일지 #{@diary.user.name} #{@diary.date}.pdf", disposition: 'inline'


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
end
