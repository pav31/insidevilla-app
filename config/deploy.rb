lock '3.4.1'

set :application, 'insidevilla'
set :domain, 'insidevilla.com'
set :user, 'deploy'
set :host, '46.101.251.156'
set :repo_url, 'git@bitbucket.org:pav31/insidevilla.git'
set :branch, 'master'

set :rails_env, 'production'

set :use_sudo, false
set :deploy_via, :copy
# set :deploy_via, :remote_cache

set :ssh_options, {
  forward_agent: true,
  keys: %W[/home/#{fetch(:user)}/.ssh/id_rsa]
}

role :app, %W[#{fetch(:user)}@#{fetch(:host)}]
role :web, %W[#{fetch(:user)}@#{fetch(:host)}]
role :db, %W[#{fetch(:user)}@#{fetch(:host)}]

set :deploy_to, "/home/#{fetch(:user)}/#{fetch(:application)}_#{fetch(:stage)}"
set :scm, :git

set :log_level, :debug

set :keep_releases, 5
set :format, :pretty
set :pty, false

set :linked_files, %w[config/secrets.yml config/database.yml config/dropbox.yml config/application.yml]
set :linked_dirs, %w[bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system]

# setup rbenv.
set :rbenv_type, :user
set :rbenv_ruby, '2.3.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby rails sidekiq sidekiq]

# what specs should be run before deployment is allowed to
# continue, see lib/capistrano/tasks/run_tests.cap
set :tests, []

set :unicorn_service, "unicorn_#{fetch(:application)}_#{fetch(:stage)}"
set :unicorn_config, shared_path.join("config/unicorn.rb")

# For initial deploy run following tasks:
# setup:upload_yml_files
# setup:upload_env
# setup:upload_config
# nginx:append_config
# !!! bundle exec cap production setup
# finally run $ cap production deploy
namespace :deploy do
  after :publishing, 'nginx:reload'
  after :publishing, 'unicorn:restart'
  # after :publishing, 'deploy:compile_assets'
  # after :publishing, 'paperclip:build_missing_styles'
  after :finishing, :cleanup
end
