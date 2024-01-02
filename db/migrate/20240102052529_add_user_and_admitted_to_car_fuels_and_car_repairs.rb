class AddUserAndAdmittedToCarFuelsAndCarRepairs < ActiveRecord::Migration[7.0]
  def change
    add_reference :car_fuels, :user, null: false, foreign_key: false
    add_reference :car_repairs, :user, null: false, foreign_key: false
    add_column :car_fuels, :admitted, :boolean
    add_column :car_repairs, :admitted, :boolean
  end
end
