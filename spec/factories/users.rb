FactoryBot.define do
  factory :user do
    email { Faker::Internet.safe_email }
    name { 'Joe Smith' }
    password { '123456asdfgh' }
  end
end
