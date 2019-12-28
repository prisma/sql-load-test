# Prisma Test Data Generator

For generating large amounts of test data to PostgreSQL and SQLite.

## Usage

The tests are now ran against PostgreSQL and an instance can be started from the
included docker-compose file:

```shell
docker-compose -f docker-compose/dev-postgres.yml up -d
```

Install latest version of `prisma2` and generate the database schema:

```shell
npm install -g prisma2
prisma2 lift up
```

Generate users/posts/comments/likes with the generator:

```shell
cargo run -- -u10000
```

This will generate 10 000 users, 100 000 posts, 100 000 comments and 500 000 likes.

By default only the users should be provided and other items are multiplied from
this number.

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

## Populate a SQLite database.

- Generate the CSVs in the `output` directory with `sql-load-test generate`.
- Inspect the SQLite schema: the order of the columns in the SQL schema and the CSVs must match for the SQLite CSV import to work. Use the `xsv` command line tool (the `select` subcommand) to reorder the columns in the CSVs to match.
- Import from the `sqlite3` prompt ([tutorial](https://www.sqlitetutorial.net/sqlite-import-csv/)).
