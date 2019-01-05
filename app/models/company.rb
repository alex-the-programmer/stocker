class Company < ApplicationRecord
    validates_presence_of :symbol, :name

    belongs_to :sector, optional: true
    has_many :companies_tags
    has_many :tags, through: :companies_tags
    has_many :stats
end
