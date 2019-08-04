# Docker API Only

This is a sample of using docker with Rails

## Usage

1. Use this repo for rails app
2. Use docker-machine to provision an instance

    ```
    docker-machine create --driver digitalocean --digitalocean-access-token={api} --digitalocean-size={size} --digitalocean-region={region} --digitalocean-ipv6=true {name}
    ```

4. Create an `.env` file by running

    ```
    cp .env.template .env
    ```

    Add the PG parameters and others

3. Then

    ```
    eval $(docker-machine env docker-api-only)

    docker-compose build db
    docker-compose up -d db
    docker-compose build app
    ```

4. Create the DB

    ```
    docker-compose run --rm app rails db:create db:migrate
    ```

5. Bring it up

    ```
    docker-compose up -d
    ```

6. If get permission denied when run init-letsencrypt.sh, remove the certbot container and the volume

    ```
    ./init-letsencrypt.sh
    sudo ./init-letsencrypt.sh
    docker rm docker-api-only_certbot_1
    docker volume rm xxx
    ```
