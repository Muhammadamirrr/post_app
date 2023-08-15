# Dockerized Rails Application
This is a Dockerized Rails application that demonstrates basic CRUD operations for managing posts.

## Prerequisites
Before you begin, ensure you have met the following requirements:
- Docker and Docker Compose are installed on your system.
## Local Setup To run the application locally without Docker, follow these steps:
1. Clone the repository:
```bash
    git clone https://github.com/your-username/your-dockerized-rails-app.git cd your-dockerized-rails-app
```
2. Install dependencies:
 ```bash
    bundle install
 ```
3. Set up the database:
 ```bash
    rails db:create
    rails db:migrate
 ```
4. Start the Rails server::
 ```bash
    rails server
 ```
5. Access the application in your web browser: http://localhost:3000:
    - Use the provided web interface to create, edit, and delete posts.
    - The app also comes with a user authentication system implemented using Devise.
3. To run the RSpec tests:
 ```bash
    rspec
 ```

## Docker Setup

To run the application using Docker, follow these steps:

1. Clone the repository:
```bash
    git clone https://github.com/your-username/your-dockerized-rails-app.git
    cd your-dockerized-rails-app
```
2. Create a .env file for environment variables (replace with your values):
3. Edit the .env file and provide your PostgreSQL database configuration.

Build and start the Docker containers
```bash
    docker-compose build
    docker-compose up
```
4. The Rails app will be accessible at http://localhost:3000.
5. Set up the database:

```bash
    docker-compose exec app rails db:create
    docker-compose exec app rails db:migrate
```
6. Access the Rails console:
```bash
    docker-compose exec app rails console
```
7. Access the application in your web browser: http://localhost:3000

Use the provided web interface to create, edit, and delete posts.
The app also comes with a user authentication system implemented using Devise.
8. To run the RSpec tests:
```bash
    docker-compose exec app rspec
```
## Cleaning Up
To stop and remove the Docker containers and volumes, use:
```bash
docker-compose down -v
```
