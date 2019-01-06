class CreateCharts < ActiveRecord::Migration[5.2]
  def change
    create_table :charts do |t|
      t.belongs_to :company, null: false
      
      t.date :date
      t.time :minute
      t.float :high
      t.float :low
      t.float :average
      t.bigint :volume
      t.float :notional
      t.integer :number_of_trades
      t.float :market_high
      t.float :market_low
      t.float :market_average
      t.bigint :market_volume
      t.float :market_notional
      t.integer :market_number_of_trades
      t.float :open
      t.float :close
      t.float :market_open
      t.float :market_Close
      t.float :change_over_time
      t.float :market_change_over_time
    end

    add_foreign_key :charts, :companies
    add_index :charts, [:company_id, :date]
  end
end
