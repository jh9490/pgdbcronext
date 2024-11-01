# PostgreSQL 13 with `pg_cron` Extension Setup

This repository provides a Docker Compose setup for running a PostgreSQL 13 container with the `pg_cron` extension enabled. The `pg_cron` extension allows you to schedule SQL-based jobs within PostgreSQL, similar to a cron job.

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
