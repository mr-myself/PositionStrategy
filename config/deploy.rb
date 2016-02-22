# config valid only for Capistrano 3.1
lock '3.4.0'

set :application, 'position_strategy'
set :repo_url, 'git@github.com:mr-myself/PositionStrategy.git'
set :database_name, 'position_strategy'
set :branch, 'master'

set :scm, :git

set :format, :pretty
set :log_level, :debug # :info or :debug
set :keep_releases, 3

set :rbenv_type, :user
set :rbenv_ruby, '2.1.4'
set :rbenv_path, '~/.rbenv'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

set :linked_dirs, %w{log tmp public/assets}

namespace :deploy do

  task :stop do
    on roles(:app) do
    end
  end

  task :graceful_stop do
    on roles(:app) do
    end
  end

  task :reload do
    on roles(:app) do
      execute "ps aux | grep unicorn | grep master | awk '{print $2}' | xargs kill -USR2"
    end
  end

  task :restart do
    on roles(:app) do
      execute "ps aux | grep unicorn | grep master | awk '{print $2}' | xargs kill -USR2"
    end
  end

  after :finishing, 'deploy:cleanup'
end

namespace :database do

  task :create do
    on roles(:db) do |host|
      execute "mysql -uroot -e 'CREATE DATABASE IF NOT EXISTS #{fetch(:database_name)};'"
    end
  end
end

before 'deploy:starting', 'database:create'
