# Prisma Test Data Generator

For generating large amounts of test data to test performance.

## Usage

The tests are now ran against PostgreSQL and an instance can be started from the
included docker-compose file:

``` shell
docker-compose -f docker-compose/dev-postgres.yml up -d
```

Install latest version of `prisma2` and generate the database schema:

``` shell
npm install -g prisma2
prisma2 lift up
```

Generate users/posts/comments/likes with the generator:

``` shell
cargo run -- -u10000
```

This will generate

- 10 000 users
- 100 000 posts
- 100 000 comments
- 500 000 likes

By default only the users should be provided and other items are multiplied from
this number, which can all be modified separately if needed.

``` text
USAGE:
    sql-load-test [OPTIONS]

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -c, --comments <num_comments>    The number of generated comments.
    -l, --likes <num_likes>          The number of generated likes.
    -p, --posts <num_posts>          The number of generated posts.
    -u, --users <num_users>          The number of generated users.
```
