--
-- pg_repack issue #3
--
CREATE TABLE issue3_1 (col1 int NOT NULL, col2 text NOT NULL);
CREATE UNIQUE INDEX issue3_1_idx ON issue3_1 (col1, col2 DESC);
SELECT migrate.get_order_by('issue3_1_idx'::regclass::oid, 'issue3_1'::regclass::oid);
\! halo_migrate --dbname=contrib_regression --table=issue3_1 --alter='ADD COLUMN c1 INT' --execute

CREATE TABLE issue3_2 (col1 int NOT NULL, col2 text NOT NULL);
CREATE UNIQUE INDEX issue3_2_idx ON issue3_2 (col1 DESC, col2 text_pattern_ops);
SELECT migrate.get_order_by('issue3_2_idx'::regclass::oid, 'issue3_2'::regclass::oid);
\! halo_migrate --dbname=contrib_regression --table=issue3_2 --alter='ADD COLUMN c1 INT' --execute

CREATE TABLE issue3_3 (col1 int NOT NULL, col2 text NOT NULL);
CREATE UNIQUE INDEX issue3_3_idx ON issue3_3 (col1 DESC, col2 DESC);
SELECT migrate.get_order_by('issue3_3_idx'::regclass::oid, 'issue3_3'::regclass::oid);
\! halo_migrate --dbname=contrib_regression --table=issue3_3 --alter='ADD COLUMN c1 INT' --execute

CREATE TABLE issue3_4 (col1 int NOT NULL, col2 text NOT NULL);
CREATE UNIQUE INDEX issue3_4_idx ON issue3_4 (col1 NULLS FIRST, col2 text_pattern_ops DESC NULLS LAST);
SELECT migrate.get_order_by('issue3_4_idx'::regclass::oid, 'issue3_4'::regclass::oid);
\! halo_migrate --dbname=contrib_regression --table=issue3_4 --alter='ADD COLUMN c1 INT' --execute

CREATE TABLE issue3_5 (col1 int NOT NULL, col2 text NOT NULL);
CREATE UNIQUE INDEX issue3_5_idx ON issue3_5 (col1 DESC NULLS FIRST, col2 COLLATE "POSIX" DESC);
SELECT migrate.get_order_by('issue3_5_idx'::regclass::oid, 'issue3_5'::regclass::oid);
\! halo_migrate --dbname=contrib_regression --table=issue3_5 --alter='ADD COLUMN c1 INT' --execute
