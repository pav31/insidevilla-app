namespace :nginx do
  desc ' Create symlink for nginx.conf in /etc/nginx/conf.d'
  task :append_config do
    on roles :all do
      sudo :ln, "-fs #{shared_path}/config/nginx.conf /etc/nginx/conf.d/#{fetch(:application)}.conf"
    end
  end

  desc 'Reload nginx'
  task :reload do
    on roles :all do
      sudo :service, :nginx, :reload
    end
  end

  desc 'Restart nginx'
  task :restart do
    on roles :all do
      sudo :service, :nginx, :restart
    end
  end
  after :append_config, :restart
end