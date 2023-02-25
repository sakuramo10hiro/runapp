FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    email { 'test@example.com' }
    introduction { '自己紹介です' }
    password { 'password' }
  end
end
