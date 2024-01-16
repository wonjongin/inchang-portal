class CreateMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings do |t|
      t.date :at
      t.text :description
      t.references :user, null: false, foreign_key: false
      t.string :title
      t.text :footnote
      t.string :is_exterior
      t.string :attendee

      t.timestamps
    end
  end
end
