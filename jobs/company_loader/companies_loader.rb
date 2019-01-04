module CompanyLoader
  class CompaniesLoader
    include Sidekiq::Worker

    def perform
      CSV.foreach 'data_files/ListOfAllStocks.csv' do |stock|
        CompanyLoader.perform_async stock[2]
      end
    end
  end
end
