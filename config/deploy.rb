# config valid only for Capistrano 3.1
# lock '3.1.0'

set :application, 'pixelinfra'
set :repo_url, 'git://github.com/pixelache/pixelinfra.git'
set :rvm_ruby_version, '2.4.2'
set :keep_releases, 3
set :linked_files, %w{config/database.yml config/application.yml config/flickr.yml }
set :linked_dirs, %w{public/system tmp public/uploads public/images public/assets log}

set :assets_roles, [:web, :app]       
 
set :puma_threads,    [4, 12]
set :puma_workers,    4
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, false


set :rails_env, 'production'
set :migrate_env, 'production'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/pixelinfra'
set :ssh_options, :compression => false, :keepalive => true


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

  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end
  
  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end
  
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  desc 'copy protected fonts'
  task :fonts do
    on roles(:app) do
      execute "mkdir #{release_path}/app/assets/fonts"
      execute "cp #{shared_path}/fonts/* #{release_path}/app/assets/fonts/"
    end
  end
  

  before :starting,     :check_revision
  before :compile_assets,  :fonts
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end


