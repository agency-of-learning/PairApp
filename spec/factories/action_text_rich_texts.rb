FactoryBot.define do
  factory :action_text_rich_text, class: 'ActionText::RichText' do
    name { Faker::Lorem.word }
    body { ActionText::Content.new "<div>#{Faker::Lorem.sentence}</div>" }
    record_type { User.name }
    record_id { create(:user).id }
  end
end
