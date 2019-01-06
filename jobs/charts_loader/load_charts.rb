module ChartsLoader
  class LoadCharts
    include Sidekiq::Worker

    def perform(from_date, to_date)
      days_range = (from_date..to_date).reject {|day| [6, 0].include?(day.wday)}
      Company.in_batches do |companies_batch|
        companies_batch.ids.each do |company_id|
          days_range.each do |day|
            LoadChart.perform_async company_id, day
          end
        end
      end
    end
  end
end
