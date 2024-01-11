FactoryBot.define do
  factory :action_text_rich_text, class: 'ActionText::RichText' do
    # +rich_text_owner+ must be given by the user of this factory, and it may
    # be any persisted ActiveRecord model record.
    transient do
      rich_text_owner { nil }
    end

    name { Faker::Lorem.word }
    body { ActionText::Content.new "<div>#{Faker::Lorem.sentence}</div>" }

    after(:build) do |action_text_rich_text, evaluator|
      if evaluator.rich_text_owner
        action_text_rich_text.record_type = evaluator.rich_text_owner.class.name
        action_text_rich_text.record_id = evaluator.rich_text_owner.id
      end
    end
  end
end
