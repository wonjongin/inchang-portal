class AddInsuranceDescToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :insurance_desc, :text
  end
end
