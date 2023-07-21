class CreateFeedbacks < ActiveRecord::Migration[7.0]
  def change
    create_table :feedbacks do |t|
      t.text :desc
      t.references :user, null: false, foreign_key: false
      t.references :diary, null: false, foreign_key: false

      t.timestamps
    end
  end
end
