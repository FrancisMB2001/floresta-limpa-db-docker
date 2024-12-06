# Floresta Limpa Database Docker Setup

## Prerequisites
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Setup Instructions

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
4. Connect to the database 
    ```
    Host: localhost
    Port: 5432
    Database: floresta_limpa_db
    Username: postgres
    Password: admin
    ```

To break down the container : 
```bash
docker-compose down -v
```

Change the username, password and database name in the ``docker-compose.yml`` file. 
