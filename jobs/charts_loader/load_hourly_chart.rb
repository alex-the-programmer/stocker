module ChartsLoader
  class LoadCharts
    include Sidekiq::Worker

    #todo rewrite if needed
    def perform(company_id, day)
      company = Company.find company_id
      response = Faraday.get "https://api.iextrading.com/1.0/stock/#{company.symbol}/chart/date/#{day.strftime("%Y%m%d")}"

      # todo this is per-minute data for the entire day
      # it would make sence to aggregate it per hour and persist.
      # then there would be a feature vector fo the entire 9 hours of market per day
    end
  end
end
