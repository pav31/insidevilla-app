namespace :setup do
  desc 'Upload database.yml file.'
  task :upload_database do
    on roles :all do
      sudo :mkdir, "-p #{shared_path}/config"
      upload! StringIO.new(File.read("config/database.yml")), "#{shared_path}/config/database.yml"
    end
  end

  desc 'Upload yml files.'
  task :upload_yml_files do
    on roles :all do
      sudo :mkdir, "-p #{shared_path}/config"
      puts 'Uploading database.yml...'
      upload! StringIO.new(File.read("config/database.yml")), "#{shared_path}/config/database.yml"
      puts 'Uploading secrets.yml...'
      upload! StringIO.new(File.read("config/secrets.yml")), "#{shared_path}/config/secrets.yml"
      puts 'Uploading application.yml...'
      upload! StringIO.new(File.read("config/application.yml")), "#{shared_path}/config/application.yml"
    end
  end

  desc 'Upload .env and .env.production settings.'
  task :upload_env do
    on roles :all do
      sudo :mkdir, "-p #{shared_path}"
      upload! StringIO.new(File.read(".env.#{fetch(:stage)}")), "#{shared_path}/.env.#{fetch(:stage)}"
      sudo :mv, "#{shared_path}/.env.#{fetch(:stage)} #{shared_path}/.env"
    end
  end

  desc 'Upload prod_env.yml and rename to local_env.yml'
  task :upload_prod_env do
    on roles :all do
      sudo :mkdir, "-p #{shared_path}"
      upload! StringIO.new(File.read("prod_env.yml")), "#{shared_path}/local_env.yml"
    end
  end

  desc 'Remove Gemfile.lock'
  task :remove_gemlock do
    on roles :all do
      sudo :rm, "#{shared_path}/Gemfile.lock"
    end
  end

  desc 'Upload config files to remote server'
  task :upload_config do
    on roles :all do
      sudo :mkdir, "-p #{shared_path}"
      %w(shared/config).each do |f|
        upload!(f, shared_path, recursive: true)
      end
    end
  end

  desc 'Upload images to remote server'
  task :upload_images do
    on roles :all do
      sudo :mkdir, "-p #{shared_path}"
      %w(app/assets/images).each do |f|
        upload!(f, shared_path, recursive: true)
      end
    end
  end

  # Example usage: cap production invoke[db:migrate]
  desc 'Invoke a rake command on the remote server'
  task :invoke, [:command] => 'deploy:set_rails_env' do |task, args|
    on primary :app  do
      within current_path do
        with rails_env: fetch(:rails_env) do
          rake args[:command]
        end
      end
    end
  end

  desc 'Creates admin user'
  task :create_admin do
    on roles :all do
      run "cd #{current_path} && script/runner -e production 'CreateAdminService.new.call'"
    end
  end
end
