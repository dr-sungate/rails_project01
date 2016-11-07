#!/bin/bash -x
source /etc/profile.d/rbenv.sh
export NOKOGIRI_USE_SYSTEM_LIBRARIES=1

bundle config without test development doc
bundle install

export RAILS_ENV=localdevelopment
export MAIN_DATABASE_POOL=100
export MAIN_DATABASE_PASSWORD=databasedev
export MAIN_DATABASE_USERNAME=root
export MAIN_DATABASE_SOCKET=/var/lib/mysql/mysql.sock
export MAIN_DATABASE_HOST=mysqlservermain
export MAIN_LINKAGE_DATABASE_HOST=mysqlserverlinkage


export SECRET_KEY_BASE=`rake secret`
rake secret>.secret
bundle exec rake db:create
bundle exec rake db:migrate




