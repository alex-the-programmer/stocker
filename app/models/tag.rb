class Tag < ApplicationRecord
    validates_presence_of :name

    has_many :companies_tags
    has_many :companies, through: :companies_tags
end
