module ChartsLoader
  class LoadCharts
    include Sidekiq::Worker

    def perform
      Company.cheap.in_batches do |companies_batch|
        companies_batch.ids.each do |company_id|
          LoadChart.perform_async company_id
        end
      end
    end
  end
end
