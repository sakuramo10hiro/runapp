FactoryBot.define do
  factory :course do
    course_name { 'テストコース作成' }
    course_description { 'テストデータの作成をする' }
    public { true }
    distance {'2.0' }
    road_type { '0' }
    toilet { '0' }
    undulation { '0' }
    signal { '0' }
    address { '東京都千代田区123-12-1' }
    route { '0' }
    user
  end
end
