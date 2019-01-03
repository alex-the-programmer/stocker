class Company < ApplicationRecord
    validates_presence_of :symbol, :name 
end
