class CreateVacationHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :vacation_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.text :reason
      t.boolean :is_approved
      t.date :start_date
      t.date :end_date
      t.integer :vacation_type

      t.timestamps
    end
  end
end
