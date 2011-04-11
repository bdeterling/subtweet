$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_ruby_string, '1.9.2@subtweet'
set :rvm_type, :system
if ENV["RAILS_ENV"] == "stage"
  set :application, "stage"
elsif ENV["RAILS_ENV"] == "production"
  set :application, "production"
else
  set :application, "test"
end
set :rails_env, application
require 'bundler/capistrano'
default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :repository, "git@github.com:bdeterling/subtweet.git"  # Your clone URL
set :scm, "git"
set :user, "brian"  # The server's user for deploys
set :branch, "development"
set :deploy_via, :remote_cache
set :deploy_to, "/var/apps/subtweet/#{application}"
set :git_shallow_clone, 1
set :scm_verbose, true
set :use_sudo, false
#ssh_options[:keys] = ["~/.ssh/id_rsa_aq_deploy"]

server "subtweet.org", :app, :web, :db, :primary => true

after "deploy", "deploy:cleanup"
after "deploy", "deploy:timestamp"

namespace :deploy do
  desc <<-DESC
  Restarts app
  DESC
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc <<-DESC
  Updates info.html with build and deploy info
  DESC
  task :timestamp do
    run "cd #{current_path}; printf '<pre>\\nDeployed on: %s\\n\\n%s\\n</pre>' \"`date`\" \"`git log -n 1`\" > public/info.html"
  end
        
=begin
  desc <<-DESC
  Loads seed data by running rake db:seed
  DESC
  task :seed, :roles => :db, :only => { :primary => true } do
    rake = fetch(:rake, "rake")
    rails_env = fetch(:rails_env, "production")
    run "cd #{current_release}; #{rake} db:seed RAILS_ENV=#{rails_env}"
  end
=end
end
