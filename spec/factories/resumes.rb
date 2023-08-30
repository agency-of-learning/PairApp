# == Schema Information
#
# Table name: resumes
#
#  id         :bigint           not null, primary key
#  current    :boolean
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_resumes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :resume do
    name { 'My Resume' }

    transient do
      user { false }
      current { nil }
    end

    after(:build) do |resume, evaluator|
      resume.user = evaluator.user || create(:user)
      resume.current = evaluator.current.nil?
      resume.resume.attach(
        io: Rails.root.join('spec/fixtures/bob_resume.pdf').open,
        filename: 'bob_resume.pdf',
        content_type: 'application/pdf'
      )
    end
  end
end
