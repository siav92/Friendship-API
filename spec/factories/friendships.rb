FactoryBot.define do
  factory :friendship do
    user
    association :friend, factory: :user
    status { :active }
  end
end
