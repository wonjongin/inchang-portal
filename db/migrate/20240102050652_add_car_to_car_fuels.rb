class AddCarToCarFuels < ActiveRecord::Migration[7.0]
  def change
    add_reference :car_fuels, :car, null: false, foreign_key: false
  end
end
