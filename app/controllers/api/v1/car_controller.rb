class Api::V1::CarController < ApplicationController
  include AuthRequest
  before_action :current_user

  def car_list
    @filter = params[:filter] || 'use'
    @cars = Car.all if @filter == 'all'
    @cars = Car.where(status: 'use') if @filter == 'use'
    @cars = Car.where(status: 'disposal') if @filter == 'disposal'
    @index = 1
  end

  def detail

  end

  def repair_list
    @car = Car.find_by(id: params[:number])
    @repairs = CarRepair.where(car: @car).order(repaired_at: :desc, odo: :desc)
    @sum_of_price = @repairs.sum(:price)
  end

  def new_car
  end

  def create_car
    c = Car.create(
      registered_at: params[:date],
      number: params[:number],
      manufacturer: params[:manufacturer],
      model: params[:model],
      insurance_company: params[:insurance_company],
      insurance_start: params[:insurance_start],
      insurance_end: params[:insurance_end],
      insurance_desc: params[:insurance_desc],
      status: 'use'
    )
    render json: {
      status: :ok,
      message: "Success!",
      code: :success,
      car_id: c.id,
    }
  end

  def new_repair
    @car = Car.find_by(id: params[:car_id])
  end

  def create_repair
    @car = Car.find_by(id: params[:car_id])
    cr = CarRepair.create(
      user: @current_user,
      repaired_at: params[:repaired_at],
      odo: params[:odo],
      center: params[:center],
      desc: params[:desc],
      price: params[:price],
      footnote: params[:footnote],
      admitted: false,
      car: @car,
    )
    render json: {
      status: :ok,
      message: "Success!",
      code: :success,
      car_repair_id: cr.id,
    }
  end

  def edit_car
    @car = Car.find_by(id: params[:car_id])
  end

  def update_car
    c = Car.find_by(id: params[:car_id])
    c.update(
      registered_at: params[:date],
      number: params[:number],
      manufacturer: params[:manufacturer],
      model: params[:model],
      insurance_company: params[:insurance_company],
      insurance_start: params[:insurance_start],
      insurance_end: params[:insurance_end],
      insurance_desc: params[:insurance_desc],
    )
  end

  def update_repair
    cr = CarRepair.find_by(id: params[:repair_id])
    cr.update(
      repaired_at: params[:repaired_at],
      odo: params[:odo],
      center: params[:center],
      desc: params[:desc],
      price: params[:price],
      footnote: params[:footnote],
    )
    render json: {
      status: :ok,
      message: "Success!",
      code: :success,
      car_repair_id: cr.id,
    }
  end

  def edit_repair
    @cr = CarRepair.find_by(id: params[:repair_id])
    @car = @cr.car
  end

  def sell_car
    @car = Car.find_by(id: params[:car_id])
  end

  def dispose_car
    car = Car.find_by(id: params[:car_id])
    car.update(
      disposed_at: params[:disposed_at],
      status: 'disposal'
    )
    render json: {
      status: :ok,
      message: "Success!",
      code: :success,
      car_id: car.id,
    }
  end

  def cancel_dispose
    car = Car.find_by(id: params[:car_id])
    car.update(
      disposed_at: nil,
      status: 'use'
    )
    redirect_to "/api/v1/car/car_list"
  end

  def fuel_list
    @car = Car.find_by(id: params[:car_id])
    @fuels = CarFuel.where(car: @car).order(refueled_at: :desc, odo: :desc)
    @sum_of_price = @fuels.sum(:price)
  end

  def new_fuel
    @car = Car.find_by(id: params[:car_id])
  end

  def edit_fuel
    @cf = CarFuel.find_by(id: params[:fuel_id])
    @car = @cf.car
  end

  def create_fuel
    @car = Car.find_by(id: params[:car_id])
    cf = CarFuel.create(
      user: @current_user,
      refueled_at: params[:refueled_at],
      odo: params[:odo],
      station: params[:station],
      price: params[:price],
      footnote: params[:footnote],
      unit_price: params[:unit_price],
      fuel_type: params[:fuel_type],
      admitted: false,
      car: @car,
    )
    render json: {
      status: :ok,
      message: "Success!",
      code: :success,
      car_fuel_id: cf.id,
    }
  end

  def update_fuel
    cf = CarFuel.find_by(id: params[:fuel_id])
    cf.update(
      refueled_at: params[:refueled_at],
      odo: params[:odo],
      station: params[:station],
      price: params[:price],
      footnote: params[:footnote],
      unit_price: params[:unit_price],
      fuel_type: params[:fuel_type],
    )
    render json: {
      status: :ok,
      message: "Success!",
      code: :success,
      car_fuel_id: cf.id,
    }
  end

  def admit
    unless @current_user.is_admin?
      flash.alert = "권한이 없어요"
      redirect_to "/api/v1/car/car_list" and return
    end

    if params[:what] == 'repair'
      crf = CarRepair
              .find_by(id: params[:id])
              .update(admitted: params[:is_admitted])
    elsif params[:what] == 'fuel'
      crf = CarFuel
              .find_by(id: params[:id])
              .update(admitted: params[:is_admitted])
    end
    render json: {
      status: :ok,
      message: "Success!",
      code: :success,
    }
  end

  def delete_repair
    cr = CarRepair.find_by(id: params[:repair_id])
    car_id = cr.car.id
    if @current_user.is_admin? || cr.admitted == false
      cr.destroy!
      flash.alert = "정비내역 1건이 삭제되었습니다."
    else
      flash.alert = "권한이 없어요"
    end
    redirect_to "/api/v1/car/repair_list/#{car_id}"
  end

  def delete_fuel
    cf = CarFuel.find_by(id: params[:fuel_id])
    car_id = cf.car.id
    if @current_user.is_admin? || cr.admitted == false
      cf.destroy!
      flash.alert = "주유내역 1건이 삭제되었습니다."
    else
      flash.alert = "권한이 없어요"
    end
    redirect_to "/api/v1/car/fuel_list/#{car_id}"
  end

  def xlsx_car_list
    @cars = Car.all
    @index = 1
    render xlsx: 'xlsx_car_list', filename: '차량목록.xlsx', formats: :xlsx
    # package = @cars.to_xlsx
    # send_data package.to_stream.read, filename: '차량목록.xlsx', type: 'application/vnd.openxmlformates-officedocument.spreadsheetml.sheet'
  end

  def xlsx_repair_list
    @car = Car.find_by(id: params[:car_id])
    @crs = @car.car_repairs
    @index = 1
    render xlsx: 'xlsx_repair_list', filename: "정비내역 (#{@car.number} #{@car.model}).xlsx", formats: :xlsx
  end

  def xlsx_fuel_list
    @car = Car.find_by(id: params[:car_id])
    @cfs = @car.car_fuels
    @index = 1
    render xlsx: 'xlsx_fuel_list', filename: "주유내역 (#{@car.number} #{@car.model}).xlsx", formats: :xlsx
  end

  def xlsx_repair_list_all
    @cars = Car.all
    render xlsx: 'xlsx_repair_list_all', filename: "정비내역 전체.xlsx", formats: :xlsx
  end

  def xlsx_fuel_list_all
    @cars = Car.all
    render xlsx: 'xlsx_fuel_list_all', filename: "주유내역 전체.xlsx", formats: :xlsx
  end
end
