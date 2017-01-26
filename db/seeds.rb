unless Rails.env.production?
  user = CreateAdminService.new.call
  puts 'CREATED ADMIN USER: ' << user.email

  puts 'Loading static pages...'
  Rake::Task['create_static_pages'].invoke

  puts 'Creating Comforts...'
  15.times do
    begin
      Fabricate(:comfort)
    rescue => @err
      puts "Comfort error: #{@err.message}"
    end
  end

  @comforts = Comfort.all

  puts 'Creating Estates with feedbacks...'
  25.times do
    Fabricate(:estate_with_feedbacks)
  end

  puts 'Creating Estates...'
  25.times do
    Fabricate(:estate)
  end

  puts 'Adding comforts to estate...'
  Estate.find_each do |estate|
    estate.update(comforts: @comforts.sample(rand(5..10)))
  end
end
