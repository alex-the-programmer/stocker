class CompaniesTag < ApplicationRecord
  belongs_to :company
  belongs_to :tag
end