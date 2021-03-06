module CompanyLoader
  class LoadCompany
    include Sidekiq::Worker

    def perform(stock_symbol)
      response = Faraday.get "https://api.iextrading.com/1.0/stock/#{stock_symbol}/company"
      if response.status != 404 && response.body != "Forbidden"
        data = JSON.parse(response.body).with_indifferent_access

        return unless data[:companyName]

        Company.create!({
                            symbol: data[:symbol],
                            name: data[:companyName],
                            exchange: data[:exchange],
                            industry: data[:industry],
                            website: data[:website],
                            description: data[:description],
                            ceo: data[:CEO],
                            issue_type: data[:issueType],
                            sector: data[:sector].present? ? Sector.find_or_create_by!(name: data[:sector]) : nil,
                            tags: data[:tags].map do |tag|
                              Tag.find_or_create_by!(name: tag)
                            end
                        })
      end
    end
  end
end
