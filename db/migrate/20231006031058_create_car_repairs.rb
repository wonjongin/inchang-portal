class CreateCarRepairs < ActiveRecord::Migration[7.0]
  def change
    create_table :car_repairs do |t|
      t.date :repaired_at
      t.integer :odo
      t.string :center
      t.text :desc
      t.integer :price
      t.text :footnote
      t.references :car, null: false, foreign_key: false

      t.timestamps
    end
  end
end
