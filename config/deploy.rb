require 'rvm/capistrano'
set :rvm_ruby_string, 'ruby-2.0.0-p247'
set :default_environment, { 
  'rvm_path' => '/usr/local/rvm',
  'PATH' => "/usr/local/rvm/gems/ruby-2.0.0-p247/bin:/usr/local/rvm/gems/ruby-2.0.0-p247@global/bin:/usr/local/rvm/rubies/ruby-2.0.0-p247/bin:/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games",
  'RUBY_VERSION' => 'ruby-2.0.0-p247',
  'GEM_HOME' =>  "/usr/local/rvm/gems/ruby-2.0.0-p247",
  'GEM_PATH' =>  "/usr/local/rvm/gems/ruby-2.0.0-p247:/usr/local/rvm/gems/ruby-2.0.0-p247@global"
}
# bundler bootstrap
require 'bundler/capistrano'
load 'deploy/assets'

set :default_shell, :bash

set :application, "pixelinfra"
set :repository,  "git://github.com/pixelache/pixelinfra.git"
set :user, "www-data"
set :password, 'with&against'
set :use_sudo, false
ssh_options[:forward_agent] = true
default_run_options[:pty] = true
set :scm, :git
set :deploy_to, "/var/www/#{application}"
# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "www.pixelache.ac"                          # Your HTTP server, Apache/etc
role :app, "www.pixelache.ac"                          # This may be the same as your `Web` server
role :db,  "www.pixelache.ac", :primary => true # This is where Rails migrations will run
set :keep_releases, 3

desc "symlink to static"
after "deploy:finalize_update", :roles => [:web, :app] do
  run <<-CMD
  ln -sf #{shared_path}/static/system #{latest_release}/public/system &&
  ln -sf #{shared_path}/static/images #{latest_release}/public/images &&
  ln -sf #{shared_path}/static/uploads #{latest_release}/public/uploads &&
  cp #{shared_path}/config/database-template.yml #{latest_release}/config/database.yml &&
  cp #{shared_path}/config/application.yml #{latest_release}/config/ &&
  chown www-data:www-data #{shared_path}/log/*
  CMD

end

namespace :mod_rails do
  desc "Restart the application altering tmp/restart.txt for mod_rails."
  task :restart, :roles => :app do
    run "touch #{release_path}/tmp/restart.txt"
  end
end
namespace :deploy do
  %w(start restart).each { |name| task name, :roles => :app do mod_rails.restart end }
end

after "deploy", "deploy:migrate"

desc 'copy ckeditor nondigest assets'
task :copy_nondigest_assets, roles: :app do
  run "cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} ckeditor:copy_nondigest_assets"
end
#after 'deploy:assets:precompile', 'copy_nondigest_assets'

