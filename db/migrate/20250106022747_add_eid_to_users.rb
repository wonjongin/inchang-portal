class AddEidToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :eid, :string
  end
end
