Fabricator(:comfort) do
  category { rand(2) }
  name_en { Faker::Lorem.word }
  name_ru { Faker::Lorem.word }
  value nil
  icon do
    if Rails.env.test?
      Rack::Test::UploadedFile.new(Dir.glob("#{Rails.root}/lib/files/images/*").sample, 'image/png')
    else
      open(Faker::Avatar.image(SecureRandom.hex(10), "20x20"), allow_redirections: :all)
    end
  end
end
