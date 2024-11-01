Certainly! Here’s the full `README.md` in the format you provided, with each section clearly broken down.

---

# PostgreSQL 13 with `pg_cron` Extension Setup

This repository provides a Docker Compose setup for running a PostgreSQL 13 container with the `pg_cron` extension enabled. The `pg_cron` extension allows you to schedule SQL-based jobs within PostgreSQL, similar to cron jobs.

## Prerequisites

- Docker
- Docker Compose

## Project Structure

- **docker-compose.yml**: Defines the services and configurations for PostgreSQL.
- **postgresql.conf**: Custom PostgreSQL configuration to load the `pg_cron` extension.
- **init.sql**: Initial SQL file to create the `pg_cron` extension within the database.

## Setup Instructions

### 1. Clone the Repository

```bash
git clone <repository_url>
cd <repository_directory>
```

### 2. Configure Environment Variables

In `docker-compose.yml`, update the following environment variables with your PostgreSQL credentials:

- `POSTGRES_USER`: PostgreSQL username
- `POSTGRES_PASSWORD`: PostgreSQL password
- `POSTGRES_DB`: Database name

### 3. Custom PostgreSQL Configuration

Ensure `postgresql.conf` includes the following lines to enable `pg_cron`:

```conf
# Include default PostgreSQL settings
include 'postgresql.auto.conf'

# pg_cron configuration
cron.database_name = 'your_db'
shared_preload_libraries = 'pg_cron'
```

Replace `your_db` with your actual database name.

### 4. Start PostgreSQL with Docker Compose

Run the following command to start the PostgreSQL container:

```bash
docker-compose up -d
```

---

## Verifying `pg_cron` Installation

### 1. Access PostgreSQL

To access PostgreSQL and verify the `pg_cron` extension, run:

```bash
docker exec -it postgres-cron psql -U your_user -d your_db
```

### 2. Enable `pg_cron`

Inside the `psql` CLI, enable `pg_cron` (if not already enabled by `init.sql`):

```sql
CREATE EXTENSION IF NOT EXISTS pg_cron;
```

---

## Usage Examples

With `pg_cron` enabled, you can now schedule SQL-based cron jobs in PostgreSQL. Below are examples of common usage.

### Example 1: Schedule a Job to Run Every Minute

```sql
SELECT cron.schedule('*/1 * * * *', 'SELECT now()');
```

- This job runs every minute and executes `SELECT now()`, which returns the current timestamp.

### Example 2: Insert Data Periodically

Insert a timestamp into a log table every hour:

```sql
SELECT cron.schedule('0 * * * *', 'INSERT INTO log_table (timestamp) VALUES (now())');
```

- This job runs every hour, at the start of the hour.

### Example 3: Cleanup Old Data Daily

To delete records older than 7 days every night at midnight:

```sql
SELECT cron.schedule('0 0 * * *', 'DELETE FROM my_table WHERE created_at < now() - interval ''7 days''');
```

- This job runs daily at midnight to clean up old data.

### Example 4: Weekly Aggregation Job

Perform a weekly data aggregation every Sunday at 3 AM:

```sql
SELECT cron.schedule('0 3 * * SUN', 'INSERT INTO weekly_summary (total, created_at) SELECT SUM(amount), now() FROM transactions');
```

- This job aggregates data from a `transactions` table into a `weekly_summary` table every week.

---

## Managing Scheduled Jobs

### List All Jobs

To view all scheduled jobs, query the `cron.job` table:

```sql
SELECT * FROM cron.job;
```

### Remove a Job

To delete a job, use `cron.unschedule` with the job ID:

```sql
SELECT cron.unschedule(job_id);
```

- Replace `job_id` with the ID of the job you want to remove.

### Update a Job

To update a job’s schedule, unschedule it first and create a new job with the updated schedule.

---

## Troubleshooting

- **Configuration Errors**: If you encounter configuration errors, ensure the `cron.database_name` and `shared_preload_libraries` parameters are correctly set in `postgresql.conf`.
- **Extension Errors**: Verify the `pg_cron` extension is correctly installed by running `CREATE EXTENSION pg_cron` in `psql`.

---

## References

- [PostgreSQL Docker Image Documentation](https://hub.docker.com/_/postgres)
- [pg_cron Documentation](https://github.com/citusdata/pg_cron)

---

This breakdown provides a complete, easy-to-follow guide to setting up and using `pg_cron` in a PostgreSQL 13 Docker container. Let me know if you need further adjustments!
