require './spec/rails_helper'
describe LearningDataPreparer::PrepareLearningRecord do
  before do
    Chart.destroy_all
    Company.destroy_all
  end
  let(:chart) {create(:chart)}
  describe '#bucket_one_decimal' do
    it 'rounds to 1 decimal point' do
      expect(subject.send(:bucket_one_decimal, 3.7415)).to eq 3.7
    end
  end

  describe '#change_features' do

  end

  describe '#high_low_for_charts' do
    describe 'when the range is 1 day' do
      it 'returns values from that chart' do
        expect(subject.send(:high_low_for_charts, chart, chart)).to eq([chart.high, chart.low])
      end
    end
    describe 'when the date is more than 1 day' do
      before do
        @min_chart
        20.times do |i|
          @min_chart = create!(:chart, comppany: chart.company, date: chart.date - i.days)
        end

        Chart.skip(5).take(1).update(high: 20)
        Chart.skip(8).take(1).update(low: -20)
      end

      it 'returns values from the range' do
        expect(subject.send(:high_low_for_charts, @min_chart, chart)).to eq([20, -20])
      end
    end
  end

  describe '#last_30_marget_days' do

  end

  describe '#last_20_weeks' do

  end

  describe '#last_24_months' do

  end

  describe '#days_that_have_charts' do

  end

  describe '#find_last_market_date_for' do

  end

  describe '#find_next_market_date_for' do

  end

  describe '#replace_holidays_with_last_market_days' do

  end

  describe '#features_for_interval' do

  end

  describe '#change_percent_in_range' do

  end
end