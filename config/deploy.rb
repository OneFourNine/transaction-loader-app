lock '3.2.1'

set :application, "transaction-load"
set :repo_url,  "git@github.com:netguru/transaction-load.git"
set :deploy_to, "/home/transaction-load/app"

set :linked_files, %w(config/database.yml config/sec_config.yml config/secrets.yml)

set :linked_dirs, %w(log tmp vendor/bundle public/uploads)

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
