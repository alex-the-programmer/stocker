module StatsLoader
  class LoadStats
    include Sidekiq::Worker

    def perform
      Company.in_batches do |batch|
        batch.ids.each do |company_id|
          LoadStat.perform_async company_id
        end
      end
    end
  end
end