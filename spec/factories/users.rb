FactoryBot.define do
  factory :user do
    email { 'joesmith@company.com' }
    name { 'Joe Smith' }
    password { '123456asdfgh' }
  end
end
