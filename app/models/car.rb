class Car < ApplicationRecord
  has_many :car_repairs
  has_many :car_fuels
end
