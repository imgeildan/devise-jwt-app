FactoryBot.define do
  factory :key_result do
    title 		{ 'title' }
    association :user 
    association :goal 
    status		{ 'in_progress' }
  end
end