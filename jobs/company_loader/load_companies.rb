require 'csv'

module CompanyLoader
  class LoadCompanies
    include Sidekiq::Worker

    def perform
      parsed_values = Set.new
      CSV.foreach 'data_files/ListOfAllStocks.csv', headers: :first_row do |stock|
        next if parsed_values.include?(stock["Symbol"])

        LoadCompany.perform_async stock["Symbol"]
        parsed_values.add(stock["Symbol"])
      end
    end
  end
end
