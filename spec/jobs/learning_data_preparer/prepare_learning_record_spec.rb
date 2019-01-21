require './spec/rails_helper'
describe LearningDataPreparer::PrepareLearningRecord do
  before(:each) do
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
        c2 =create(:company, symbol: :foo)
        create(:chart, company: c2, low: -100)
        @min_chart
        20.times do |i|
          @min_chart = create(:chart, company: chart.company, date: chart.date - i.days)
        end

        Chart.offset(5).limit(1).update_all(high: 20)
        Chart.offset(8).limit(1).update_all(low: -20)
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
    describe 'when the last day is a week day' do
      describe 'when there are charts for that day' do
        it 'returns that day' do
        last_day_chart =create(:chart, company: chart.company, date: chart.date - 1.day)
          expect(subject.send(:find_last_market_date_for, chart.date)).to eq last_day_chart.date
        end
      end
      describe 'when there is no charts for that day' do
        describe 'when there are earlier days' do
          it 'returns that day' do
          last_day_chart=create(:chart, company: chart.company, date: chart.date - 2.day)
            expect(subject.send(:find_last_market_date_for, chart.date)).to eq last_day_chart.date
          end
        end

        describe 'when there is no earlier days for that symbol' do
          # TODO think what should be happening here
        end
      end
    end

    describe 'when the last day is a weekend' do
      it'returns the last friday' do
        friday_chart = create(:chart, company: chart.company, date: '01/11/2019')
        monday_chart = create(:chart, company: chart.company, date: '01/14/2019')
        expect(subject.send(:find_last_market_date_for, monday_chart.date)).to eq friday_chart.date
      end
    end
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