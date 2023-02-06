FactoryBot.define do
  factory :comment do
    comment_content { 'コメント内容です' }
    user
    course
  end
end
