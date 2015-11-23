#!/bin/bash
echo '=================================='
echo ' Free Law Machine [PostgreSQL]'
echo '=================================='

sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'password';"
sudo -u postgres createuser django --createdb
sudo -u postgres psql -c "ALTER ROLE django WITH PASSWORD 'password';"

# hat tip: http://stackoverflow.com/questions/8351436/change-lc-ctype-for-postgresql-and-postgis-use
sudo -u postgres createdb -E UTF8 --locale=en_US.utf8 -O django courtlistener -T template0

echo "localhost:5432:*:postgres:password" >> ~/.pgpass
echo "localhost:5432:courtlistener:django:password" >> ~/.pgpass
chmod 0600 ~/.pgpass
sudo chown vagrant:vagrant ~/.pgpass

# fix up the authentication settings, hacky and expects psql 9.3
sudo sed 's/peer/md5/g' -i /etc/postgresql/9.3/main/pg_hba.conf

# restart to get changes to take effect
sudo service postgresql restart
