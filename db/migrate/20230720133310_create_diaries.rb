class CreateDiaries < ActiveRecord::Migration[7.0]
  def change
    create_table :diaries do |t|
      t.date :date
      t.references :user, null: false, foreign_key: false

      t.timestamps
    end
  end
end
