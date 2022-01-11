FactoryBot.define do
  factory :goal do
    title 		{ 'title' }
    association :user
    start_date  { Date.today } 
    end_date    { Date.tomorrow } 
  end
end