class CreateCharts < ActiveRecord::Migration[5.2]
  def change
    create_table :charts do |t|
      t.belongs_to :company, null: false

      t.date :date
      t.float :open
      t.float :high
      t.float :low
      t.float :close
      t.bigint :volume
      t.float :vwap
    end

    add_foreign_key :charts, :companies
    add_index :charts, [:company_id, :date]
  end
end
