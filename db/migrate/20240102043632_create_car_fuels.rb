class CreateCarFuels < ActiveRecord::Migration[7.0]
  def change
    create_table :car_fuels do |t|
      t.date :refueled_at
      t.integer :odo
      t.string :station
      t.integer :price
      t.text :footnote

      t.timestamps
    end
  end
end
