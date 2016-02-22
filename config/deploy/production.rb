set :stage, :production

set :rails_env, 'production'
set :bundle_gemfile, -> { release_path.join('Gemfile') }
set :bundle_dir, -> { shared_path.join('bundle') }
set :bundle_flags, '--deployment --quiet'
set :bundle_without, %w{development test}.join(' ')
set :bundle_binstubs, -> { shared_path.join('bin') }
set :bundle_roles, :all

role :app, %w{user-name@IP.ADDRESS}
role :web, %w{user-name@IP.ADDRESS}
role :db,  %w{user-name@IP.ADDRESS}

set :deploy_to, '/home/user-name/position_strategy'
set :ssh_options, {
  port: 22,
  forward_agent: true
}

set :database_name, 'position_strategy'

namespace :database do

  task :backup do
    on roles(:db) do
      execute 'mkdir -p ~/backup'
      execute "mysqldump -uroot #{fetch(:database_name)} > ~/backup/ps-#{Time.now.to_i}.sql"
    end
  end
end

before 'deploy:starting', 'database:backup'
