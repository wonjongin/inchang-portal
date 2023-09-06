class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :desc
      t.string :icon
      t.boolean :read
      t.integer :about
      t.references :user, null: false, foreign_key: false

      t.timestamps
    end
  end
end
