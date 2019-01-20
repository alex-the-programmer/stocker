module LearningDataPreparer
  class PrepareLearningRecords
    include Sidekiq::Worker

    def perform
      market_dates = Chart.select(:date).order(date: :desc).distinct
      Company.cheap.ids.each do |company_id|
        market_dates.skip(1).each do |date|
          PrepareLearningRecord.perform_async company_id, date
        end
      end
    end
  end
end
