class CreateCarLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :car_logs do |t|
      t.date :at
      t.references :user, null: false, foreign_key: true
      t.references :car, null: false, foreign_key: true
      t.integer :purpose # 사용목적
      t.string :depart # 출발지
      t.string :arrive # 도착지
      t.integer :odo  # 도착누적주행거리

      t.timestamps
    end
  end
end
