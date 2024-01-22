class AddAdmittedToMeetings < ActiveRecord::Migration[7.0]
  def change
    add_column :meetings, :admitted, :integer
  end
end
