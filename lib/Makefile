#
# halo_migrate: lib/Makefile
#
# Portions Copyright (c) 2024, Halo Tech Co.,Ltd.
# Portions Copyright (c) 2008-2012, NIPPON TELEGRAPH AND TELEPHONE CORPORATION
# Portions Copyright (c) 2011, Itagaki Takahiro
# Portions Copyright (c) 2012-2020, The Reorg Development Team
#

PG_CONFIG ?= pg_config

# version as a number, e.g. 9.1.4 -> 901
VERSION := $(shell $(PG_CONFIG) --version | sed 's/.* \([[:digit:].]\{1,\}\).*/\1/')
INTVERSION := $(shell echo $$(($$(echo $(VERSION).0 | sed 's/\([[:digit:]]\{1,\}\)\.\([[:digit:]]\{1,\}\).*/\1*100+\2/'))))

EXTENSION = halo_migrate
MODULE_big = $(EXTENSION)

OBJS = migrate.o pgut/pgut-spi.o

SHLIB_EXPORTS = exports.txt


# It is not possible to create tables with OIDs on PostgreSQL 12 or later
ifeq ($(shell echo $$(($(INTVERSION) < 1200))),1)
    RELHASOIDS := relhasoids
else
    RELHASOIDS := false
endif

# The version number of the program. It should be the same of the library.
MIGRATE_VERSION = $(shell grep '"version":' ../META.json | head -1 \
	| sed -e 's/[ 	]*"version":[ 	]*"\(.*\)",/\1/')

PG_CPPFLAGS = -DMIGRATE_VERSION=$(MIGRATE_VERSION)

DATA_built = halo_migrate--$(MIGRATE_VERSION).sql halo_migrate.control

USE_PGXS = 1
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)

# remove dependency on libxml2, libxslt, and libpam.
# XXX: find a better way to make sure we are linking with libraries
# from pg_config which we actually need.
LIBS := $(filter-out -lpam -lxml2 -lxslt, $(LIBS))

halo_migrate.sql: halo_migrate.sql.in
	echo "BEGIN;" > $@; \
	sed 's,MODULE_PATHNAME,$$libdir/$(MODULE_big),g' $< \
	| sed 's,MIGRATE_VERSION,$(MIGRATE_VERSION),g' >> $@; \
	echo "COMMIT;" >> $@;

halo_migrate--$(MIGRATE_VERSION).sql: halo_migrate.sql.in
	sed 's,MIGRATE_VERSION,$(MIGRATE_VERSION),g' $< \
	| sed 's,relhasoids,$(RELHASOIDS),g'> $@;

halo_migrate.control: halo_migrate.control.in
	sed 's,MIGRATE_VERSION,$(MIGRATE_VERSION),g' $< > $@
