class AddCheapToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :cheap, :boolean, null: false, default: false
  end
end
