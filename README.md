# Docker API Only

This is a sample of using docker with Rails

# Usage

1. create an instance with docker-machine
2. Run `cp .env.template .env`, and add the ENV variables
2. Run
    ```
    docker-compose up -d db
    docker-compose run --rm app rake db:create db:migrate
    docker-compose up -d app
    docker-compose -f nginx-proxy-compose.yml up -d
    ```
4. Visit your domain
