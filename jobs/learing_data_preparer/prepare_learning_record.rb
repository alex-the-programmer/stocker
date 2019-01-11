module LearningDataPreparer
  class PrepareLearningRecord
    include Sidekiq::Worker

    def perform(company_id, date)
      company = Company.find(company_id)

      date_chart = company.charts.find_by(date)
      earliest_date_available = Chart.minimum(:date)
      learning_record = {}

      learning_record[:price_bucket] = bucket_one_decimal(date_chart.close)

      # last 30 market days
      if date - 30.days >= earliest_date_available
        learning_record.merge!(features_for_interval(last_30_marget_days(company_id, date), date_chart, 'day'))
        learning_record[:has_30_market_days_data] = true
      else
        learning_record[:has_30_market_days_data] = false
      end

      # last 20 weeks
      if date - 20.weeks >= earliest_date_available
        learning_record.merge!(features_for_interval(last_20_weeks(company_id, date), date_chart, 'week'))
        learning_record[:has_20_weeks_data] = true
      else
        learning_record[:has_20_weeks_data] = false
      end

      # last 24 months
      if date - 24.months >= earliest_date_available
        learning_record.merge!(features_for_interval(last_24_months(company_id, date), date_chart, 'month'))
        learning_record[:has_24_months_data] = true
      else
        learning_record[:has_24_months_data] = false
      end

      learning_record[:has_earnings_call_today] = 'TBD'
      learning_record[:will_have_earnings_call_tomorrow] = 'TBD'
      learning_record[:max_positive_open_close_change_percent_bucket_in_the_past_year] = 'TBD'
      learning_record[:max_negative_open_close_change_percent_bucket_in_the_past_year] = 'TBD'
      learning_record[:max_positive_high_low_change_percent_bucket_in_the_past_year] = 'TBD'
      learning_record[:time_from_ipo]='TBD'
      learning_record[:month_year] = 'TBD'
      learning_record[:_week_month_year] = 'TBD'
      learning_record[:has_extra_high_positive_close_open_change_percent_today] = 'tbd'
      learning_record[:has_extra_high_negative_close_open_change_percent_today] = 'tbd'
      learning_record[:has_extra_high_positive_high_low_change_percent_today] = 'tbd'

      learning_record = learning_record.map do |key, value|
        {["feature_#{key}"] => value}
      end.to_h

      learning_record[:feature_trend] = 'TBD'
      learning_record[:feature_change_percent_bucket] = 'TBD'
      learning_record[:feature_will_have_extra_high_positive_change_percent] = 'TBD'
    end

    private

    def bucket_one_decimal(value)
      value.round(1)
    end

    def change_features(date_from_chart, date_to_chart)
      has_trend = date_to_chart.close.present? && date_from_chart.open.present?
      has_high_low = date_from_chart.high.present? && date_from_chart.low.present? && date_to_chart.high.present? && date_to_chart.low.present?
      date_range_high, date_range_low = high_low_for_charts(date_from_chart, date_to_chart) if has_high_low

      {
          has_trend: has_trend,
          trend: has_trend ? (date_to_chart.close - date_from_chart.open > 0 ? 'upward' : 'downward') : nil,
          change_percent_bucket_open_close: has_trend ? bucket_one_decimal(date_to_chart.close - date_from_chart.open) : nil,
          has_high_low: has_high_low,
          change_percent_bucket_high_low: has_high_low ? bucket_one_decimal(date_range_high - date_range_low): nil,
          volume_bucket: "TBD todo",
          vwap_bucket: 'TBD todo',
          market_change_percent_bucket: 'TBD todo',
          industry_change_percent_bucket: 'TBD todo'
      }
    end

    def high_low_for_charts(date_from_chart, date_to_chart)
      return date_from_chart.high, date_from_chart.low if date_from_chart == date_to_chart

      Chart
        .where(company_id: date_from_chart.company_id)
        .where('date between ? and  ?', date_from_chart.date, date_to_chart.date)
        .pluck('max(high, min(low)')
    end

    def last_30_marget_days(date, company_id)
      # rejecting weekends
      days = (date - 6.weeks).reject{|day| [0, 6].include?(day.wday)}
      # rejecting holidays
      days_that_have_charts = days_that_have_charts(days, company_id)
      days_that_have_charts.take(30)
    end

    def last_20_weeks(date, company_id)
      dates = []
      20.times do |index|
        dates << date - index.weeks
      end

      replace_holidays_with_last_market_days(dates, company_id)
    end

    def last_24_months(date, company_id)
      dates = []
      24.times do |index|
        dates << date - index.months
      end

      replace_holidays_with_last_market_days(dates, company_id)
    end

    def days_that_have_charts(days, company_id)
      Chart.where(company_id: company_id, date: days).select(:date).order(:date).distinct
    end

    def find_last_market_date_for(date)
      offset = 1
      while(true) do
        return date - offset.days if Chart.any?(date: date - offset.days)
        offset += 1
      end
    end

    def replace_holidays_with_last_market_days(dates, company_id)
      days_that_have_charts = days_that_have_charts(dates, company_id)
      dates.map do |date|
        days_that_have_charts.include?(date) ? date : find_last_market_date_for(date)
      end
    end

    def features_for_interval(interval_days, date_chart, interval_label)
      result = {}
      interval_days.each_with_index  do |date, day_number|
        from_day_chart = company.charts.find_by(date: date)
        change_features = change_features(from_day_chart, date_chart)
        change_features.each do |key, value|
          result["#{interval_label}_#{day_number}_#{key}".to_sym] = value
        end
      end

      result
    end
  end
end
