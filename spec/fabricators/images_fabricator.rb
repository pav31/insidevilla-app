Fabricator(:image) do
  name { FFaker::HipsterIpsum.words(rand(2)).join(' ') }
  attachment do
    if Rails.env.test?
      Rack::Test::UploadedFile.new(Dir.glob("#{Rails.root}/lib/files/images/*").sample, 'image/png')
    else
      open(Faker::Placeholdit.image("600x600", 'jpg', Faker::Color.hex_color.gsub('#',''), "000", Faker::Hipster.word), allow_redirections: :all)
    end
  end
end
