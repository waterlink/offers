FactoryGirl.define do
  factory :offers_request do
    sequence(:uid) { |n| "user #{n}" }
    page 1
    pub0 ''

    factory :invalid_offers_request do
      uid ''
      page 'test'
      pub0 ''

      after :build do |offers_request|
        offers_request.valid?
      end
    end
  end
end
