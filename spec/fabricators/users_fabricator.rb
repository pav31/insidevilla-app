Fabricator(:user) do
  name { Faker::Name.name }
  email { sequence(:email) { |n| n.to_s + Faker::Internet.email } }
  password { Faker::Internet.password }
  confirmed_at Time.now
  current_sign_in_at { 5.minutes.ago }
  current_sign_in_ip { Faker::Internet.public_ip_v4_address }
  last_sign_in_at { 1.day.ago }
  last_sign_in_ip { Faker::Internet.public_ip_v4_address }
end