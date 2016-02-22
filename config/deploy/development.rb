set :stage, :development

role :app, %{vagrant@localhost}
role :web, %{vagrant@localhost}
role :db, %{vagrant@localhost}

set :deploy_to, '/home/vagrant/positionstrategy'
