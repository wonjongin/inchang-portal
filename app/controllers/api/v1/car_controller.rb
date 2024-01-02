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
      repaired_at: params[:repaired_at],
      odo: params[:odo],
      center: params[:center],
      desc: params[:desc],
      price: params[:price],
      footnote: params[:footnote],
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
end
