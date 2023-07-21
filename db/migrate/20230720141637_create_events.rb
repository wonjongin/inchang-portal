class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.text :desc
      t.references :diary, null: false, foreign_key: false

      t.timestamps
    end
  end
end
