puts "Yeti Production Deploy"

set :application, "yeti"
set :repository, "git@github.com:ericzou/yeti.git"  # Your clone URL
default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :scm, :git

ssh_options[:forward_agent] = true

set :branch, "master"

set :deploy_via, :remote_cache

set :deploy_to, "/data/www/yeti"
set :shared_path, "/data/www/yeti/shared"
set :rails_env, "production"
set :user, :ubuntu
set :use_sudo, true
set :rake, "/opt/ruby-enterprise-1.8.7-2010.02/bin/rake"

role :web, "175.41.142.164"                          # Your HTTP server, Apache/etc
role :app, "175.41.142.164"                          # This may be the same as your `Web` server
role :db,  "175.41.142.164", :primary => true # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :link_database_config, :roles => :app do 
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config" # sync the database.yml file 
  end
  task :link_sphinx_config, :roles => :app do 
    run "ln -nfs #{shared_path}/config/production.sphinx.conf #{release_path}/config" # sync sphinx file 
  end
  task :rebuild_sphinx_index, :roles => :app do 
    run "sudo /opt/ruby-enterprise-1.8.7-2010.02/bin/rake -f /data/www/yeti/current/Rakefile ts:rebuild RAILS_ENV=production" # rebuild index
  end
  before "deploy:migrate", "deploy:link_database_config"
  after "deploy:migrate", "deploy:link_sphinx_config"
  after "deploy:link_sphinx_config", "deploy:rebuild_sphinx_index"  
end