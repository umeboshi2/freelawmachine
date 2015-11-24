#!/bin/bash
echo '=================================='
echo ' Free Law Machine [PostgreSQL]'
echo '=================================='

echo 'Creating users...'
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'password';"
sudo -u postgres createuser django --createdb
sudo -u postgres psql -c "ALTER ROLE django WITH PASSWORD 'your-password';"

echo 'Creating courtlistener db...'
# hat tip: http://stackoverflow.com/questions/8351436/change-lc-ctype-for-postgresql-and-postgis-use
sudo -u postgres createdb -E UTF8 --locale=en_US.utf8 -O django courtlistener -T template0

echo 'Setting up .pgpass...'
echo "localhost:5432:*:postgres:password" >> ~/.pgpass
echo "localhost:5432:courtlistener:django:your-password" >> ~/.pgpass
chmod 0600 ~/.pgpass
sudo chown vagrant:vagrant ~/.pgpass

echo 'Finagling pg_hba.conf to use md5...'
# fix up the authentication settings, hacky and expects psql 9.3
sudo sed 's/peer/md5/g' -i /etc/postgresql/9.3/main/pg_hba.conf

echo 'Flipping PostgreSQL for changes to take effect...'
# restart to get changes to take effect
sudo service postgresql restart
