class AddUnitPriceToCarFuels < ActiveRecord::Migration[7.0]
  def change
    add_column :car_fuels, :unit_price, :float
    add_column :car_fuels, :fuel_type, :integer
  end
end
