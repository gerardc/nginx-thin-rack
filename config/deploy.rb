set :application, "app_name"
set :domain,      "yourdomain.com" # or IP address
set :repository,  "git@bitbucket.org:username/app_name.git"

set :deploy_to,   "/home/username/rack_apps/#{application}/"
set :port, 1234
set :rvm_shell, "/home/username/.rvm/bin/rvm-shell"
set :scm,         "git"
set :scm_passphrase, "your_password"
set :use_sudo,    false
set :user, :username
set :thin_config, "config/thin.yml"
default_run_options[:pty] = true

role :web, domain
role :app, domain
role :db,  domain, :primary => true

namespace :deploy do
  task :start do
    run <<-CMD
      cd #{latest_release}; #{rvm_shell} -c 'bundle exec thin start -C #{thin_config}'
    CMD
  end

  task :stop do 
    run <<-CMD
      cd #{latest_release}; #{rvm_shell} -c 'bundle exec thin stop -C #{thin_config}'
    CMD
  end

  task :restart do 
    run <<-CMD
      cd #{latest_release}; #{rvm_shell} -c 'bundle exec thin restart -C #{thin_config}'
    CMD
  end

  desc "Bundle gems"
  task :bundle do
    run "cd #{release_path}; #{rvm_shell} -c 'bundle'"
  end

  # mkdir -p is making sure that the directories are there for some SCM's that don't save empty folders
  desc "Create project folders"
  task :create_project_folders do
    run <<-CMD
      rm -rf #{latest_release}/log &&
      mkdir -p #{latest_release}/public &&
      mkdir -p #{latest_release}/tmp &&
      ln -s #{shared_path}/log #{latest_release}/log &&
      ln -s #{shared_path}/sockets #{latest_release}/tmp/sockets
    CMD
  end

  # Another task example...
  #
  # desc "Compile assets"
  # task :compile_assets do
  #   run "cd #{release_path}; {rvm_shell} -c 'bundle exec rake assets:precompile'"
  # end

end

after 'deploy:update_code', 'deploy:create_project_folders'
after 'deploy:update_code', 'deploy:bundle'
