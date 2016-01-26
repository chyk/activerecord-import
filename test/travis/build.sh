#!/bin/bash
set -e
set +x

function run {
  echo "Running: AR_VERSION=$AR_VERSION $@"
  $@
}

for activerecord_version in "4.2" ; do
  export AR_VERSION=$activerecord_version

  bundle update activerecord

  run bundle exec rake test:postgresql              # Run tests for postgresql
  run bundle exec rake test:seamless_database_pool  # Run tests for seamless_database_pool
  run bundle exec rake test:spatialite              # Run tests for spatialite
  # so far the version installed in travis seems < 3.7.11 so we cannot test sqlite3 on it
  # run bundle exec rake test:sqlite3

  #jruby
  #bundle exec rake test:jdbcmysql               # Run tests for jdbcmysql
  #bundle exec rake test:jdbcpostgresql          # Run tests for jdbcpostgresql
done
