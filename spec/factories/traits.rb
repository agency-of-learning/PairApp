FactoryBot.define do
  trait :skip_validation do
    to_create { |instance| instance.save(validate: false) }
  end
end
