# config valid only for Capistrano 3.1
# lock '3.1.0'

set :application, 'pixelinfra'
set :repo_url, 'git://github.com/pixelache/pixelinfra.git'
set :rvm_ruby_version, '2.2.2'
set :keep_releases, 3
set :linked_files, %w{config/database.yml config/application.yml config/flickr.yml }
set :linked_dirs, %w{public/system public/uploads public/images public/assets log}
set :rails_env, 'production'
set :migrate_env, 'production'
set :rvm_type, :system
# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/pixelinfra'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  desc 'copy protected fonts'
  task :fonts do
    on roles(:app) do
      execute "mkdir #{release_path}/app/assets/fonts"
      execute "cp #{shared_path}/fonts/* #{release_path}/app/assets/fonts/"
    end
  end
      
  before "assets:precompile", "deploy:fonts"
  after "deploy:fonts", "deploy:migrate"
  after "deploy:migrate", "deploy:cleanup"
  after "deploy:cleanup", "deploy:restart"
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
