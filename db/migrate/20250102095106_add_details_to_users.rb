class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :hire_date, :date
    add_column :users, :position, :string
    add_column :users, :status, :integer
  end
end
