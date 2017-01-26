Fabricator(:feedback) do
  author FFaker::Name.name
  email { sequence(:email) { |n| n.to_s + Faker::Internet.email } }
  city FFaker::Address.city
  approved true
  occupation FFaker::Job.title
  body { FFaker::HipsterIpsum.paragraph(rand(1..7)) }
  photo do
    if Rails.env.test?
      Rack::Test::UploadedFile.new(Dir.glob("#{Rails.root}/lib/files/images/*").sample, 'image/png')
    else
      open(Faker::Avatar.image(SecureRandom.hex(10), "600x600"), allow_redirections: :all)
    end
  end
end
