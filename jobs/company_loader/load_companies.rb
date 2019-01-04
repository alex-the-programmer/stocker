require 'csv'

module CompanyLoader
  class LoadCompanies
    include Sidekiq::Worker

    def perform
      CSV.foreach 'data_files/ListOfAllStocks.csv', headers: :first_row do |stock|
        LoadCompany.perform_async stock["Symbol"]
      end
    end
  end
end
