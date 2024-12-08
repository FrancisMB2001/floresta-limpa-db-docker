# Floresta Limpa Database Docker Setup

## Prerequisites
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Setup Instructions - Local with Docker Compose 

1. Clone the repository and navigate to the directory:
   ```bash
   git clone https://github.com/FrancisMB2001/floresta-limpa-db-docker
   cd floresta-limpa-db-docker
    ```
2. Start the docker container:
    ```bash
    docker-compose up -d
    ```
3. Verify that the database is running and the number of tables is 103:
    ```bash
    docker logs postgres-db
    ```
4. Connect to the database with this information:
    ```
    Host: localhost
    Port: 5432
    Database: floresta_limpa_db
    Username: postgres
    Password: admin
    ```
    Command :
    ```bash
    docker exec -it postgres-db psql -U postgres -d floresta_limpa_db
    ```

To break down the container : 
```bash
docker-compose down -v
```

Change the username, password and database name in the ``docker-compose.yml`` file. 

## Setup Instructions - Docker Image
1. Open Docker Desktop or a terminal with Docker installed.
2. Pull the image, either through Docker Desktop or with the following command: 
```bash
docker pull francismb2001/floresta-limpa-db:latest
```
3. Run the image as a container:
```bash
docker run --name postgres-db -d -p 5432:5432 francismb2001/floresta-limpa-db:latest
```


