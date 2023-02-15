FactoryBot.define do
  factory :website do
    sequence(:url) { |n| "https://example.com/#{n}" }
    sequence(:feed_title) { |n| "feed-title-#{n}" }
    sequence(:feed_url) { |n| "https://example.com/feed-#{n}" }
  end

  factory :post
end
