class AddInsuranceCompanyToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :insurance_company, :string
  end
end
