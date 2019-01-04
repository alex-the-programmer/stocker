module CompanyLoader
  class CompanyLoader
    include Sidekiq::Worker

    def perform(stock_symbol)
      response = Faraday.get "https://api.iextrading.com/1.0/stock/#{stock_symbol}/company"

      if response.status != 404
        data = response.data

        Company.create!({
                            symbol: data[:symbol],
                            name: data[:companyName],
                            exchange: data[:exchange],
                            industry: data[:industry],
                            website: data[:website],
                            description: data[:description],
                            ceo: data[:CEO],
                            issue_ype: data[:issueType],
                            sector: Sector.find_or_create_by!(name: data[:sector]),
                            tags: data[:tags].each do |tag|
                              Tag.find_or_create_by!(name: tag)
                            end
                        })
      end
    end
  end
end
