# halo_migrate -- Perform schema changes in Halo/PostgreSQL with minimal locks

- Project: https://github.com/HaloLab001/halo_migrate



## About

halo_migrate is a Halo/PostgreSQL extension and CLI which lets you make schema
changes to tables and indexes. Unlike `ALTER TABLE` it works online, without
holding a long lived exclusive lock on the processed tables during the
migration. It builds a copy of the target table and swaps them.

Please check the documentation (in the ``doc`` directory or online) for
installation and usage instructions.

Forked from the excellent pg_migrate project (https://github.com/phillbaker/pg_migrate).

## Supported Product Versions

Halo >= 14, PostgreSQL >= 14

## Installation

Get the source from project's git site: 

```
git clone https://github.com/HaloLab001/halo_migrate.git
```

Then to make && make install, for example, for Halo 14:
```
export USE_PGXS=1
make
make install
```

Load the halo_migrate extension in the database you want to work on:
```
psql -c "DROP EXTENSION IF EXISTS halo_migrate cascade; CREATE EXTENSION halo_migrate" -d halo0root
```

## Examples

### Change the type of a column

```
halo_migrate --table=my_table --alter='ALTER COLUMN id TYPE bigint' # Add --execute to run
```

### Add a column with a default (non-nullable)

```
halo_migrate --table=my_table --alter='ADD COLUMN foo integer NOT NULL DEFAULT 42' # Add --execute to run
```

## Known Limitations

* Unique constraints are converted into unique indexes, [they are equivalent in Halo/PostgreSQL](https://stackoverflow.com/questions/23542794/postgres-unique-constraint-vs-index). However, this may be an unexpected change.
* Index names on the target table and foreign key constraints are changed during the migration.
  * If the generated names are > 63 characters, this will likely break
* If the target table is used in views, those objects will continue to reference the original table - this is not supported currently.
  * If the target table is used in stored procedures, those functions are stored as text so are not linked through object IDs and will reference the migrated table.
* DDL to drop columns is not currently supported
* Hosted PG databases (RDS, Cloud SQL) are not supported because they do not allow installing custom extensions.

