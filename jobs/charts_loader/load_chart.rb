module ChartsLoader
  class LoadChart
    include Sidekiq::Worker

    def perform(company_id)
      company = Company.find(company_id)
      response = Faraday.get "https://api.iextrading.com/1.0/stock/#{company.symbol}/chart/5y"
      data = JSON.parse(response.body)

      charts = data.with_indifferent_access.map do |chart|
        {
            company_id: company_id,
            date: chart[:date],
            open: chart[:open],
            high: chart[:high],
            low: chart[:low],
            close: chart[:close],
            volume: chart[:volume],
            vwap: chart[:volume]
        }
      end

      status = Chart.import charts
      raise "#{status.failed_instances.count} charts failed to insert" if charts.failed_instances.any?
    end
  end
end
