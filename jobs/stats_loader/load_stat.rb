module StatsLoader
  class LoadStat
    include Sidekiq::Worker

    def perform(company_id)
      company = Company.find(company_id)

      response = Faraday.get "https://api.iextrading.com/1.0/stock/#{company.symbol}/stats"
      raise "Request for stats for #{company.symbol} failed with status #{response.status}" unless response.success?
      data = JSON.parse(response.body).with_indifferent_access

      company.stats.create!(
          marketcap: data[:marketcap],
          beta: data[:beta],
          week_52_high: data[:week52high],
          week_52_low: data[:week52low],
          week_52_change: data[:week52change],
          short_interest: data[:shortInterest],
          short_date: replace_zero_with_null(data[:shortDate]),
          dividend_rate: data[:dividendRate],
          dividend_yield: data[:dividendYield],
          ex_dividend_date: replace_zero_with_null(data[:exDividendDate]),
          latest_eps: data[:latestEPS],
          latest_eps_date: replace_zero_with_null(data[:latestEPSDate]),
          shares_outstanding: data[:sharesOutstanding],
          float: data[:float],
          return_on_equity: data[:returnOnEquity],
          consensus_eps: data[:consensusEPS],
          number_of_estimates: data[:numberOfEstimates],
          eps_surprise_dollar: data[:EPSSurpriseDollar],
          eps_surprise_percent: data[:EPSSurprisePercent],
          ebitda: data[:EBITDA],
          revenue: data[:revenue],
          gross_profit: data[:grossProfit],
          cash: data[:cash],
          debt: data[:debt],
          ttm_eps: data[:ttmEPS],
          revenue_per_share: data[:revenuePerShare],
          revenue_per_employee: data[:revenuePerEmployee],
          pe_ratioH_high: data[:peRatioHigh],
          pe_ratio_low: data[:peRatioLow],
          return_on_assets: data[:returnOnAssets],
          return_on_capital: data[:returnOnCapital],
          profit_margin: data[:profitMargin],
          price_to_sales: data[:priceToSales],
          price_to_book: data[:priceToBook],
          day_20_moving_avg: data[:day200MovingAvg],
          day_50_moving_avg: data[:day50MovingAvg],
          institution_percent: data[:institutionPercent],
          insider_percent: data[:insiderPercent],
          short_ratio: data[:shortRatio],
          year_5_change_percent: data[:year5ChangePercent],
          year_2_change_percent: data[:year2ChangePercent],
          year_1_change_percent: data[:year1ChangePercent],
          ytd_change_percent: data[:ytdChangePercent],
          month_6_change_percent: data[:month6ChangePercent],
          month_3_change_percent: data[:month3ChangePercent],
          month_1_change_percent: data[:month1ChangePercent],
          day_5_change_percent: data[:day5ChangePercent],
          day_30_change_percent: data[:day30ChangePercent],
      )
    end

    private
    def replace_zero_with_null(value)
      value == "0" || value == 0 ? nil : value
    end

    #todo clenup NaN values from revenue per emploee
  end
end