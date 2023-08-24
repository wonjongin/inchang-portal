class CreateCashios < ActiveRecord::Migration[7.0]
  def change
    create_table :cashios do |t|
      t.date :date, null: false 
      t.integer :io
      t.string :account
      t.text :desc
      t.text :note
      t.integer :price, null: false
      t.boolean :is_base_balance
      t.boolean :admitted
      t.references :user, null: false, foreign_key: false

      t.timestamps
    end
  end
end
