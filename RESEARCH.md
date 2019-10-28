# Prisma SQL Performance

Prisma Query Engine might not always query the database in the fastest possible
query. In this research we'll dig into different possible queries and their
execution performance.

## Test Setup

### Data

Test data is generated using the
[sql-load-test crate](https://github.com/prisma/sql-load-test). The
[datamodel](https://github.com/prisma/sql-load-test/blob/master/prisma/schema.prisma)
consists of users, posts, comments and likes.

The test generator generates N users with an unique ID. It then generates 10N
posts, 10N comments and 50N likes connecting them randomly with each other,
allowing us to test joins. Every user should have about the same amount of
posts, comments and likes. Comments are linked to users and posts, likes to
users and either to a post or to a comment.

In this test we generate 300k users, 3M posts, 3M comments and 15M likes.

### Query Engine

The query engine is taken from the [bench
branch](https://github.com/prisma/prisma-engine/tree/bench), containing all
possible improvements on IO execution performance.

## Test Queries

### Simple Join

``` graphql
query {
  findOneUser(where: { id: 3 })
  {
    id,
    firstName,
    lastName,
    age,
    email,
    password,
    posts { id }
  }
}
```

Resulting SQL:

``` sql
SELECT
    "sql_load_test"."User"."id",
    "sql_load_test"."User"."firstName",
    "sql_load_test"."User"."lastName",
    "sql_load_test"."User"."age",
    "sql_load_test"."User"."email",
    "sql_load_test"."User"."password"
FROM "sql_load_test"."User"
WHERE "sql_load_test"."User"."id" = 3
ORDER BY "sql_load_test"."User"."id" ASC
LIMIT 1 OFFSET 0;
```

Query time: 1ms

``` sql
SELECT
    "sql_load_test"."Post"."id",
    "RelationTable"."id" AS "__RelatedModel__",
    "RelationTable"."author" AS "__ParentModel__"
FROM "sql_load_test"."Post"
INNER JOIN "sql_load_test"."Post" AS "RelationTable" ON "sql_load_test"."Post"."id" = "RelationTable"."id"
WHERE (("RelationTable"."author" IN (3) AND 1=1) AND 1=1) ORDER BY "RelationTable"."id" ASC;
```

Query time: 450ms.

Here we see how the latter query takes almost half a second to execute, which
should not be the case.

The database schema shows only one index in `Post`:

```
  Column   |              Type              | Collation | Nullable |                      Default
-----------+--------------------------------+-----------+----------+----------------------------------------------------
 content   | text                           |           |          |
 createdAt | timestamp(3) without time zone |           | not null | '1970-01-01 00:00:00'::timestamp without time zone
 id        | integer                        |           | not null | nextval('"Post_id_seq"'::regclass)
 updatedAt | timestamp(3) without time zone |           | not null | '1970-01-01 00:00:00'::timestamp without time zone
 author    | integer                        |           |          |
Indexes:
    "Post_pkey" PRIMARY KEY, btree (id)
    "Post.id" UNIQUE, btree (id)
Foreign-key constraints:
    "Post_author_fkey" FOREIGN KEY (author) REFERENCES "User"(id) ON DELETE SET NULL
```

Let's simplify the slow query and see the execution plan:

```
postgres=# explain (select * from "Post" where author = 1);
                                 QUERY PLAN
----------------------------------------------------------------------------
 Gather  (cost=1000.00..303977.15 rows=3 width=738)
   Workers Planned: 2
   ->  Parallel Seq Scan on "Post"  (cost=0.00..302976.85 rows=1 width=738)
         Filter: (author = 1)
```

We see a full table scan! Not good. Let's try adding an index to the column:

``` sql
CREATE UNIQUE INDEX post_author ON "Post" (author, id);
```

Now the full table scan is gone:

```
postgres=# explain (select * from "Post" where author = 1);
                                 QUERY PLAN
-----------------------------------------------------------------------------
 Index Scan using post_author on "Post"  (cost=0.43..16.48 rows=3 width=738)
   Index Cond: (author = 1)
(2 rows)
```

And when running our GraphQL query, both SQL queries take less than one
millisecond.

#### Actions

PostgreSQL is not indexing foreign keys by default. We should either instruct
the users to do the indexing in the datamodel, or automatically create them to
the schema when having using foreign keys.
