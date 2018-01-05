#!/usr/local/bin/bash
set -x
set -e

# To be run after a brew update && brew upgrade posgres

# Note: don't need to do migrations for minor semver upgrades i.e. 1.1.x++

# @TODO make this script run the actual upgrade as well – next time we want to upgrade postgres

brew services stop postgresql

# Get current version numbers
readarray -t versions <<< "$(ls -1 /usr/local/Cellar/postgresql/)"
old="9.6.1"
new="10.1"


# @TODO should probably confirm at this point if we want to continue

exit # @TODO things go wrong and this script is not repeatable so you might want to do this manually


initdb /usr/local/var/postgres-$new -E utf8

pg_upgrade \
  -d /usr/local/var/postgres \
  -D /usr/local/var/postgres-$new \
  -b /usr/local/Cellar/postgresql/$old/bin/ \
  -B /usr/local/Cellar/postgresql/$new/bin/ \
  -v

mv /usr/local/var/postgres /usr/local/var/postgres-$old-old
mv /usr/local/var/postgres-$new /usr/local/var/postgres

brew services start postgresql

# @TODO make this script remove the old version of postgres with prompt?
# rm -rf /usr/local/var/postgres-$old-old
