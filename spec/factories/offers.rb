FactoryGirl.define do
  factory :offer do
    sequence(:title) { |n| "Offer #{n}" }
    sequence(:payout) { |n| 15 * n }
    sequence(:thumbnail) { |n| "https://www.google.com/images/srpr/logo#{n}w.png" }
    sequence(:link) { |n| "https://www.google.com/search?q=Offer+#{n}" }
  end
end
