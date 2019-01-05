class CreateStats < ActiveRecord::Migration[5.2]
  def change
    create_table :stats do |t|
      t.belongs_to :company, null: false

      t.float :marketcap
      t.float :beta
      t.float :week_52_high
      t.float :week_52_low
      t.float :week_52_change
      t.float :short_interest
      t.integer :short_date
      t.float :dividend_rate
      t.float :dividend_yield
      t.date :ex_dividend_date
      t.float :latest_eps
      t.date :latest_eps_date
      t.integer :shares_outstanding
      t.float :float
      t.float :return_on_equity
      t.float :consensus_eps
      t.integer :number_of_estimates
      t.float :eps_surprise_dollar
      t.float :eps_surprise_percent
      t.float :ebitda
      t.float :revenue
      t.float :gross_profit
      t.float :cash
      t.float :debt
      t.float :ttm_eps
      t.float :revenue_per_share
      t.float :revenue_per_employee
      t.float :pe_ratioH_high
      t.float :pe_ratio_low
      t.float :return_on_assets
      t.float :return_on_capital
      t.float :profit_margin
      t.float :price_to_sales
      t.float :price_to_book
      t.float :day_20_moving_avg
      t.float :day_50_moving_avg
      t.float :institution_percent
      t.float :insider_percent
      t.float :short_ratio
      t.float :year_5_change_percent
      t.float :year_2_change_percent
      t.float :year_1_change_percent
      t.float :ytd_change_percent
      t.float :month_6_change_percent
      t.float :month_3_change_percent
      t.float :month_1_change_percent
      t.float :day_5_change_percent
      t.float :day_30_change_percent

      t.timestamps
    end

    add_foreign_key :stats, :companies
  end
end
