#!/bin/bash
set -e

# Wait for the database to be ready
(
  until pg_isready -h "127.0.0.1" -p "5432" -U "postgres"; do
    echo "Waiting for database to be ready..."
    sleep 2
  done

  # Run the pg_restore command
  pg_restore -a -W -F tar -v -h 127.0.0.1 -p 5432 -U postgres -d floresta_limpa_db /docker-entrypoint-initdb.d/backup-data-florestalimpa.tar
) &

# Execute the default entrypoint script
exec docker-entrypoint.sh postgres