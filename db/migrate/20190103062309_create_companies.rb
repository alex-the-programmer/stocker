class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :symbol, null: false
      t.string :name, null: false
      t.string :exchange
      t.string :industry
      t.string :website
      t.string :description
      t.string :ceo
      t.string :issue_type
      t.string :sector

      t.timestamps
    end
  end
end
