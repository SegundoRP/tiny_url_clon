FactoryBot.define do
  factory :visit do
    ip_address { 'Some ip address' }
    user_agent { 'Some user agent' }
    referer { 'Some referer' }
  end
end
