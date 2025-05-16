FactoryBot.define do
  factory :shortened_url do
    full_url { 'http://example.com' }
    token { 'tegJ28' }
  end
end
