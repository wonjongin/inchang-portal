class AddAdmittedToDiary < ActiveRecord::Migration[7.0]
  def change
    add_column :diaries, :admitted, :boolean
  end
end
