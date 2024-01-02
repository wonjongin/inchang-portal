class Api::V1::CarController < ApplicationController
  include AuthRequest
  before_action :current_user

  def car_list
    @cars = Car.all
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
      model: params[:model]
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
end
