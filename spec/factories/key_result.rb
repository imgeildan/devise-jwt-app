FactoryBot.define do
  factory :key_result do
    association :user 
    association :goal 
    title 		{ 'title' }
    status		{ 'in_progress' }
  end
end