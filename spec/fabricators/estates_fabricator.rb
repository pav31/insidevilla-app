Fabricator(:estate) do
  title_en { FFaker::HipsterIpsum.words(rand(1..2)).join(' ') }
  title_ru { FFaker::HipsterIpsum.words(rand(1..2)).join(' ') }
  description_en { FFaker::HipsterIpsum.paragraph(rand(5..10)) }
  description_ru { FFaker::HipsterIpsum.paragraph(rand(5..10)) }
  region { Estate.regions.sample }
  tenure_type { Estate.tenure_types.sample }
  estate_type { Estate.estate_types.sample }
  estate_class { Estate.estate_classes.sample }
  cleaning_period { (Estate.cleaning_periods + [nil]).sample }
  featured { [true, false].sample }
  address FFaker::Address.street_address
  latitude FFaker::Geolocation.lat
  longitude FFaker::Geolocation.lng
  area_size { rand(20..200) }
  price_cents { rand(30..5000) * 100 }
  available true
  draft false
  bedrooms { rand(1..5) }
  bathrooms { rand(1..5) }
  sea_distance { rand(0.1..20.0).round(2) }
  main_image do
    if Rails.env.test?
      Rack::Test::UploadedFile.new(Dir.glob("#{Rails.root}/lib/files/images/*").sample, 'image/png')
    else
      open(Faker::Placeholdit.image("1200x1200", 'jpg', Faker::Color.hex_color.gsub('#',''), "000", Faker::Hipster.word), allow_redirections: :all)
    end
  end

  slider do
    if Rails.env.test?
      Rack::Test::UploadedFile.new(Dir.glob("#{Rails.root}/lib/files/images/*").sample, 'image/png')
    else
      open(Faker::Placeholdit.image("1666x792", 'jpg', Faker::Color.hex_color.gsub('#',''), "000", Faker::Hipster.word), allow_redirections: :all)
    end
  end

  before_validation do |estate, _|
    estate.update(
      price_cents: (estate.price_cents / 100).ceil * 100,
      price_day_low_cents: (estate.price_cents / 30 * 1.5 / 100).ceil * 100,
      price_day_high_cents: estate.price_cents / 30 * 2 / 100 * 100,
      price_day_pick_cents: estate.price_cents / 30 * 3 / 100 * 100,
      price_week_low_cents: (estate.price_cents / 4 * 1.5 / 100).ceil * 100,
      price_week_high_cents: estate.price_cents / 4 * 2 / 100 * 100,
      price_week_pick_cents: estate.price_cents / 4 * 3 / 100 * 100,
      price_month_low_cents: (estate.price_cents * 1.5 / 100).ceil * 100,
      price_month_high_cents: estate.price_cents * 2 / 100 * 100,
      price_month_pick_cents: estate.price_cents * 3 / 100 * 100
    )
  end
end

Fabricator(:estate_with_images, from: :estate) do
  after_create do |estate, _|
    images { rand(3..7).times.map { Fabricate(:image) } }
  end
end

Fabricator(:estate_with_feedbacks, from: :estate) do
  after_create do |estate, _|
    feedbacks { rand(3..7).times.map { Fabricate(:feedback, estate: estate) } }
  end
end

Fabricator(:estate_with_comforts, from: :estate) do
  after_build do
    comforts { rand(3..7).times.map { Fabricate(:comfort) } }
  end
end
