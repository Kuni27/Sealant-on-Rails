# Do not have to continuously run rake commands in the Heroku when pushing new commands
release: rake db:migrate && rake db:seed
web: bundle exec puma -C config/puma.rb