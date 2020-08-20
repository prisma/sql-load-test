# Prisma Test Data Generator

For generating large amounts of test data to PostgreSQL and SQLite in CSV files.

```text
sql-load-test 0.1.0
Prisma Test Data Generator

USAGE:
    sql-load-test <SUBCOMMAND>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

SUBCOMMANDS:
    generate           Generate sample data as CSV.
    help               Prints this message or the help of the given subcommand(s)
    import-postgres    Import the generated CSVs into postgres.
```

## Usage

An ephemeral PostgreSQL instance can be started with the included docker-compose file:

```shell
docker-compose -f docker-compose/dev-postgres.yml up -d
```

Install latest version of Prisma CLI and migrate the database schema:

```shell
npm install -g @prisma/cli
prisma migrate save --name "init" --experimental
prisma migrate up --experimental
```

Generate users/posts/comments/likes with the generator:

```shell
cargo run -- -u10000
```

This will generate 10.000 users, 100.000 posts, 100.000 comments and 500.000 likes (1x, 10x, 10x, 50x).

By default only the users need to be provided and other items are multiplied from this number.

## Import CSV files to Postgres database

`TODO`

## Import CSV files to SQLite database.

- Generate the CSVs in the `output` directory with `sql-load-test generate`.
- Inspect the SQLite schema: the order of the columns in the SQL schema and the CSVs must match for the SQLite CSV import to work. Use the `xsv` command line tool (the `select` subcommand) to reorder the columns in the CSVs to match.
- Import from the `sqlite3` prompt ([tutorial](https://www.sqlitetutorial.net/sqlite-import-csv/)).

TODO add commands required for the generated CSV files
