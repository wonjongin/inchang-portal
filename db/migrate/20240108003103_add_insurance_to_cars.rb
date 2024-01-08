class AddInsuranceToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :insurance_start, :date
    add_column :cars, :insurance_end, :date
    add_column :cars, :status, :integer
    add_column :cars, :disposed_at, :date
  end
end
