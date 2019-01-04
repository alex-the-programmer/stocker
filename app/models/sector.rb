class Sector < ApplicationRecord
  has_many :companies
  has_many :ssector_performances
end
