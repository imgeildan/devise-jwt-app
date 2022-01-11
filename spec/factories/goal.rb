FactoryBot.define do
  factory :goal do
  	association :user
    title       { 'title' }
    start_date  { Date.today } 
    end_date    { Date.tomorrow } 
  end
end