class Api::V1::CashioController < ApplicationController
  include AuthRequest
  before_action :current_user

  def new
    @preset_date = params[:date] if params[:date]
    @preset_date = Date.today unless params[:date]
  end

  def new_base_balance
    @preset_date = params[:date] if params[:date]
    @preset_date = Date.today unless params[:date]
  end

  def list
    @now_page = params[:page] if params[:page]
    @now_page = 1 unless params[:page]
    @cashios = Cashio.all.order(date: :desc).order(id: :desc).page(@now_page).per(50)
  end

  def create_base_balance
    author = @current_user
    c = Cashio.create do |t|
      t.date = params[:date]
      t.price = params[:price]
      t.io = 'input'
      t.is_base_balance = true
      t.user = author
      t.admitted = false
    end
    render json: {
      status: :ok,
      message: "Success!",
      code: :success,
      cashio_id: c.id,
    }
  end

  def create
    author = @current_user
    k = 1
    k = -1 if params[:io] == 'output'
    c = Cashio.create do |t|
      t.date = params[:date]
      t.account = params[:account]
      t.desc = params[:desc]
      t.price = k * params[:price].to_i
      t.note = params[:note]
      t.io = params[:io]
      t.is_base_balance = false
      t.user = author
      t.admitted = false
    end
    render json: {
      status: :ok,
      message: "Success!",
      code: :success,
      cashio_id: c.id,
    }
  end

  def edit
    @cashio = Cashio.find_by(id: params[:id])
  end

  def update
    author = @current_user
    k = 1
    k = -1 if params[:io] == 'output'
    c = Cashio.find_by(id: params[:id])
    c.update(
      date: params[:date],
      account: params[:account],
      desc: params[:desc],
      price: k * params[:price].to_i,
      note: params[:note],
      io: params[:io],
      is_base_balance: false,
      user: author,
      admitted: false,
    )
    render json: {
      status: :ok,
      message: "Success!",
      code: :success,
      cashio_id: c.id,
    }
  end

  def delete
    if @current_user.is_admin?
      c = Cashio.find_by(id: params[:id])
      c.destroy!
      redirect_to "/api/v1/cashio/list"
    else
      flash.alert = "권한이 없어요"
      redirect_to "/api/v1/cashio/list"
    end
  end

  def admit
    unless @current_user.is_admin?
      flash.alert = "권한이 없어요"
      redirect_to "/api/v1/cashio/list" and return
    end
    c = Cashio.find_by(id: params[:id])
    c.update(
      admitted: params[:is_admitted],
      )
    render json: {
      status: :ok,
      message: "Success!",
      code: :success,
      cashio_id: c.id,
    }
  end

  def search
  end
end
