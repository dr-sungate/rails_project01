#!/bin/bash -x
source /etc/profile.d/rbenv.sh

export NOKOGIRI_USE_SYSTEM_LIBRARIES=1

export RAILS_ENV=localdevelopment

export MAIN_DATABASE_POOL=100
export MAIN_DATABASE_PASSWORD=databasedev
export MAIN_DATABASE_USERNAME=root
export MAIN_DATABASE_SOCKET=/var/lib/mysql/mysql.sock
export MAIN_DATABASE_HOST=mysqlservermain
export MAIN_LINKAGE_DATABASE_HOST=mysqlserverlinkage


# 開発サーバ起動
bundle exec rails s -b 0.0.0.0

