Fabricator(:booking) do
  move_in_at       { Date.current + rand(0..90).days }
  move_out_at      { |attrs| attrs[:move_in_at] + rand(1..91).days }
  name             { FFaker::Name.name }
  email            { FFaker::Internet.email }
  phone_number     { FFaker::PhoneNumber.phone_number }
  adults           { rand(1..6) }
  kids             { rand(0..6) }
  status           'pending'
  comment          { FFaker::HipsterIpsum.paragraph(2) }
  airport_transfer false
  car_rental       false
  escort_service   false
  estate           { Fabricate(:estate) }
end
