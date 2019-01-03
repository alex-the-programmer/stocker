class AddIndexesToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_index :companies, :symbol, unique: true
    add_index :tags, :name, unique: true
  end
end
