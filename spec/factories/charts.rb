FactoryBot.define do
  factory :chart do
    company
    date '01/10/19'
    open 3.5
    high 3.7
    low 3.1
    close 3.2

    factory :friday_chart do
      date '01/11/19'
    end

    factory :monday_chart do
      date '01/14/19'
    end
  end
end
