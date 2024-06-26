--
-- do migration
--

\! halo_migrate --dbname=contrib_regression --table=tbl_cluster --alter='ADD COLUMN a1 INT' --execute
\! halo_migrate --dbname=contrib_regression --table=tbl_badindex --alter='ADD COLUMN a1 INT' --execute
\! halo_migrate --dbname=contrib_regression --table=tbl_gistkey --alter='ADD COLUMN a1 INT' --execute
\! halo_migrate --dbname=contrib_regression --table=tbl_only_ckey --alter='ADD COLUMN a1 INT' --execute
\! halo_migrate --dbname=contrib_regression --table=tbl_idxopts --alter='ADD COLUMN a1 INT' --execute
\! halo_migrate --dbname=contrib_regression --table=tbl_only_pkey --alter='ADD COLUMN a1 INT' --execute
\! halo_migrate --dbname=contrib_regression --table=tbl_order --alter='ADD COLUMN a1 INT' --execute
\! halo_migrate --dbname=contrib_regression --table=tbl_with_dropped_column --alter='ADD COLUMN a1 INT' --execute
\! halo_migrate --dbname=contrib_regression --table=tbl_with_dropped_toast --alter='ADD COLUMN a1 INT' --execute
\! halo_migrate --dbname=contrib_regression --table=tbl_with_view --alter='ADD COLUMN a1 INT' --execute
\! halo_migrate --dbname=contrib_regression --table=tbl_with_mod_column_storage --alter='ADD COLUMN a1 INT' --execute
\! halo_migrate --dbname=contrib_regression --table=tbl_with_toast --alter='ADD COLUMN a1 INT' --execute

-- modify column type
\! halo_migrate --dbname=contrib_regression --table=tbl_cluster --alter='ALTER COLUMN a1 TYPE bigint' --execute
\! halo_migrate --dbname=contrib_regression --table=tbl_idxopts --alter='ALTER COLUMN a1 TYPE numeric' --execute
\! halo_migrate --dbname=contrib_regression --table=tbl_idxopts --alter='ALTER COLUMN i TYPE numeric' --execute