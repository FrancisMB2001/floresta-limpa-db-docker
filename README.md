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

**There are two folders, each representing a different way to initialize the database docker container, either with only the tables (schema) created or with both the tables and populated with data provided by a .tar file.**

### Empty Tables Container

The `empty-tables` container initializes the database with the schema only, without any preloaded data.

2. Navigate to the `empty-tables` directory:
    ```bash
    cd empty-tables
    ```
3. Start the docker container:
    ```bash
    docker-compose up -d
    ```
4. Verify that the database is running and the number of tables is 103:
    ```bash
    docker logs postgres-db
    ```
5. Connect to the database with this information:
    ```
    Host: localhost
    Port: 5435
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

### Preloaded Tables Container

The `preloaded-tables` container initializes the database and restores data from a `.tar` file, specifically named `backup-data-florestalimpa.tar`, to populate the database.

2. Navigate to the `preloaded-tables` directory:
    ```bash
    cd preloaded-tables
    ```
3. Drop/Copy your `backup-data-florestalimpa.tar` in the directory.
4. Start the docker container:
    ```bash
    docker-compose up -d
    ```
5. Verify that the database is running and the data has been restored:
    ```bash
    docker logs postgres-db
    ```
6. Connect to the database with this information:
    ```
    Host: localhost
    Port: 5435
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