class Api::V1::CarLogController < ApplicationController
  include AuthRequest
  before_action :current_user

  def list
    @car = Car.find_by(id: params[:car_id])
    @carlogs = CarLog.where(car: @car).order(at: :desc, odo: :desc)
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
  end

  def update
  end

  def delete
  end

  def xlsx_log
    @car = Car.find_by(id: params[:car_id])
    @cls = @car.car_logs.order(at: :asc, odo: :asc)
    @index = 1
    render xlsx: 'xlsx_log', filename: "업무차운행기록 #{@car.number}.xlsx", formats: :xlsx
  end
end
