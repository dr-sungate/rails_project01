set :stage, :production
set :branch, 'master'
set :rails_env, 'production'

role :app, %w{user@127.0.0.1}
role :web,  %w{user@127.0.0.1}
role :db,  %w{user@127.0.0.1}
