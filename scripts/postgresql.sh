#!/bin/bash
echo '=================================='
echo ' Free Law Machine [PostgreSQL]'
echo '=================================='

sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'the-super-user-password';"
sudo -u postgres psql -c "CREATE ROLE django WITH PASSWORD 'django-password';"
sudo service postgresql restart

sudo -u postgres creatdb -U django -E utf8 -O django courtlistener -T template0

echo "localhost:5432:*:postgres:the-super-user-password" >> ~/.pgpass
echo "localhost:5432:courtlistener:django:django-password" >> ~/.pgpass
chmod 0600 ~/.pgpass
