FactoryGirl.define do
  factory :offers_request do
    sequence(:uid) { |n| "user #{n}" }
    page 1
    pub0 ''
  end
end
