class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :number
      t.string :model
      t.string :manufacturer
      t.date :registered_at
      t.string :nickname

      t.timestamps
    end
  end
end
