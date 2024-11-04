# Start with the official PostgreSQL image as the base
FROM postgres:13

# Set environment variables for PostgreSQL
ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=admin
ENV POSTGRES_DB=test_db

# Install necessary packages
RUN apt-get update && \
    apt-get install -y postgresql-13-cron && \
    rm -rf /var/lib/apt/lists/*

# Copy initialization script and configuration file
COPY init.sql /docker-entrypoint-initdb.d/init.sql
COPY postgresql.conf /var/lib/postgresql/data/postgresql.conf

# Ensure the default PostgreSQL config file is in place (if needed)
RUN cp /usr/share/postgresql/postgresql.conf.sample /var/lib/postgresql/data/postgresql.conf.sample

# Command to run PostgreSQL with the custom configuration file
CMD ["postgres", "-c", "config_file=/var/lib/postgresql/data/postgresql.conf"]

# Expose PostgreSQL port
EXPOSE 5432
