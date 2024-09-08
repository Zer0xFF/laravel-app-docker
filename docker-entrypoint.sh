#!/bin/bash
set -e

# Set the working directory
cd /var/www/html

git config --global --add safe.directory /var/www/html
# Initialize Git repository if not already initialized
echo 
if [ ! -d ".git" ]; then
  echo "Initializing Git repository..."
  git init
  git remote add origin $GIT_URL
else
  git remote set-url origin $GIT_URL
fi

# Fetch the latest changes and checkout the specified branch or commit
echo "Fetching latest changes..."
git fetch origin
git checkout ${GIT_BRANCH:-main} -f

# Install deps
composer install --no-interaction --prefer-dist --optimize-autoloader
npm install && npm run build

# Check if .env is set up
if [ ! -f ".env" ]; then
  echo "Setting up .env file..."
  cp .env.example .env
  echo "Generating Key...."
  php artisan key:generate
else
  echo ".env file already set up."
fi

# Run migrations
echo "Running migrations..."
php artisan migrate

# Set appropriate permissions
chown -R www-data:www-data .

# Continue with the default CMD
echo "Running CMD.... '$@'"
exec "$@"
