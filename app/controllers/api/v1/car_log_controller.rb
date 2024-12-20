class Api::V1::CarLogController < ApplicationController
  include AuthRequest
  before_action :current_user

  def list
    @car = Car.find_by(id: params[:car_id])

    if params[:year] == nil
      today = Date.today
      @year = today.year
    else
      @year = params[:year].to_i
    end
    date = Date.new(@year, 1, 1)
    @carlogs = CarLog.where(car: @car, at: date..date.end_of_year).order(at: :desc, odo: :desc)
  end

  def new
    @car = Car.find_by(id: params[:car_id])
  end

  def create
    @car = Car.find_by(id: params[:car_id])
    @user = User.find_by(name: params[:user])
    car_log = CarLog.create(
      at: params[:at],
      user: @user,
      car: @car,
      purpose: params[:purpose],
      depart: params[:depart],
      arrive: params[:arrive],
      odo: params[:odo],
    )


    render json: {
      status: :ok,
      message: "Success!",
      code: :success,
      car_log_id: car_log.id,
    }
  end

  def edit
    @cl = CarLog.find_by(id: params[:carlog_id])
    @car = @cl.car
  end

  def update
    cl = CarLog.find_by(id: params[:carlog_id])
    cl.update(
      at: params[:at],
      user: User.find_by(name: params[:user]),
      purpose: params[:purpose],
      depart: params[:depart],
      arrive: params[:arrive],
      odo: params[:odo],
    )
    render json: {
      status: :ok,
      message: "Success!",
      code: :success,
      car_log_id: cl.id,
    }
  end

  def delete
    cl = CarLog.find_by(id: params[:carlog_id])
    car_id = cl.car.id
    if @current_user.is_admin?
      cl.destroy!
      flash.alert = "주유내역 1건이 삭제되었습니다."
    else
      flash.alert = "권한이 없어요"
    end
    redirect_to "/api/v1/car_log/list/#{car_id}"
  end

  def xlsx_form
    @car = Car.find_by(id: params[:car_id])
  end

  def xlsx_log
    start_date = params[:start]
    end_date = params[:end]

    ss = Date.parse(start_date).strftime('%y%m%d')
    es = Date.parse(end_date).strftime('%y%m%d')
    @car = Car.find_by(id: params[:car_id])
    @cls = @car.car_logs.where(at: start_date..end_date).order(at: :asc, odo: :asc)
    @index = 1
    render xlsx: 'xlsx_log', filename: "업무차운행기록-#{@car.number}-#{ss}-#{es}.xlsx", formats: :xlsx
  end
end
