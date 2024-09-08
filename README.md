# Laravel App Docker

This repository provides a Docker setup to deploy a Laravel project directly from a Git repository. The Docker image will clone the Laravel project, set it up, and run it using Apache.

On each boot, the Docker image will:
- Fetch and check out the associated Git repository and branch.
- Run `composer install` to install PHP dependencies.
- Run `npm install` to install front-end dependencies.
- Run `php artisan migrate` to update the database schema.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed on your system.
- [Docker Compose](https://docs.docker.com/compose/install/) installed on your system.

## Environment Variables

The following environment variables are required to configure the **Laravel application**:

- **`APP_NAME`**: The name of your Laravel application (default: `laravel_app`).
- **`DB_CONNECTION`**: The database connection type (default: `sqlite`).
- **`DB_DATABASE`**: The location of the SQLite database file (default: `/var/www/html/database/database.sqlite`).

The following environment variables are required to configure the **Docker environment**:

- **`GIT_URL`**: The URL of the Git repository to clone the Laravel project from.
- **`GIT_BRANCH`**: The branch or commit to check out from the Git repository (default: `origin/main`).

## How to Use

### Step 1: Create a Docker Compose File 

You can either create a new `docker-compose.yml` file or copy the template provided in this repository.

### Step 2: Setup The Above Environment Variables

### Step 3: Run Docker Compose

`docker-compose up -d --build`

### Step 4: Access Laravel Application

`http://localhost`

