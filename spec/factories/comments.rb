FactoryBot.define do
  factory :comment do
    content { "MyText" }
    user { nil }
    commentable { nil }
  end
end
