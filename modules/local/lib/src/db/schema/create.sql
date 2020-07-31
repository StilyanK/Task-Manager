CREATE TABLE IF NOT EXISTS "laboratory_unit"
(
    "laboratory_unit_id" serial PRIMARY KEY,
    "name"               text NOT NULL,
    "system"             text NOT NULL,
    UNIQUE ("name", "system")
);

CREATE TABLE IF NOT EXISTS "currency"
(
    "currency_id"     smallserial NOT NULL PRIMARY KEY,
    "title"           varchar(20) NOT NULL DEFAULT '',
    "symbol"          varchar(10) NOT NULL DEFAULT '',
    "symbol_position" smallint    NOT NULL DEFAULT 0,
    "active"          bool        NOT NULL DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS "currency_history"
(
    "currency_history_id" serial      NOT NULL PRIMARY KEY,
    "date"                timestamptz NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS "currency_data"
(
    "currency_id"         smallint       NOT NULL,
    "currency_history_id" integer        NOT NULL,
    "rate"                decimal(12, 5) NOT NULL DEFAULT 0,
    PRIMARY KEY ("currency_id", "currency_history_id")
);

CREATE TABLE IF NOT EXISTS "country"
(
    "country_id" serial         NOT NULL PRIMARY KEY,
    "name"       varchar(128)   NOT NULL DEFAULT '',
    "iso"        char(2)        NOT NULL DEFAULT '',
    "geo_lat"    decimal(12, 4) NULL,
    "geo_lng"    decimal(12, 4) NULL,
    "active"     smallint       NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS "country_loc"
(
    "country_id"  integer      NOT NULL REFERENCES "country" ON DELETE CASCADE,
    "language_id" smallint     NOT NULL,
    "name"        varchar(128) NOT NULL DEFAULT '',
    PRIMARY KEY ("country_id", "language_id")
);

CREATE TABLE IF NOT EXISTS "country_zone"
(
    "country_zone_id" serial         NOT NULL PRIMARY KEY,
    "country_id"      integer        NOT NULL,
    "name"            varchar(128)   NOT NULL DEFAULT '',
    "iso"             char(5)        NOT NULL DEFAULT '',
    "geo_lat"         decimal(12, 4) NULL,
    "geo_lng"         decimal(12, 4) NULL,
    "active"          smallint       NOT NULL DEFAULT 0
);
CREATE INDEX "country_zone_country_id" ON "country_zone" USING btree ("country_id");

CREATE TABLE IF NOT EXISTS "country_zone_loc"
(
    "country_zone_id" integer      NOT NULL REFERENCES "country_zone" ON DELETE CASCADE,
    "language_id"     smallint     NOT NULL,
    "name"            varchar(128) NOT NULL DEFAULT '',
    PRIMARY KEY ("country_zone_id", "language_id")
);

CREATE TABLE IF NOT EXISTS "language"
(
    "language_id" smallserial    NOT NULL PRIMARY KEY,
    "name"        varchar(128)   NOT NULL DEFAULT '',
    "code"        char(2) UNIQUE NOT NULL DEFAULT '',
    "locale"      char(5) UNIQUE NOT NULL DEFAULT '',
    "active"      bool           NOT NULL DEFAULT FALSE,
    "position"    smallint       NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS "quantity_unit"
(
    "quantity_unit_id" serial         NOT NULL PRIMARY KEY,
    "unit"             varchar(30)    NOT NULL DEFAULT '',
    "intl"             jsonb          NOT NULL,
    "value"            decimal(12, 5) NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS "weight_unit"
(
    "weight_unit_id" serial         NOT NULL PRIMARY KEY,
    "unit"           varchar(30)    NOT NULL DEFAULT '',
    "intl"           jsonb          NOT NULL,
    "value"          decimal(12, 5) NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS "payment_method"
(
    "payment_method_id" serial      NOT NULL PRIMARY KEY,
    "name"              varchar(30) NOT NULL DEFAULT '',
    "intl"              jsonb       NOT NULL,
    "settings"          jsonb,
    "active"            smallint    NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS "dictionary"
(
    "dictionary_id" serial              NOT NULL PRIMARY KEY,
    "name"          varchar(100) UNIQUE NOT NULL,
    "intl"          jsonb               NOT NULL
);

CREATE TABLE IF NOT EXISTS "tax_rate"
(
    "tax_rate_id"     smallserial    NOT NULL PRIMARY KEY,
    "name"            varchar(100)   NOT NULL DEFAULT '',
    "intl"            jsonb          NOT NULL,
    "rate"            decimal(12, 5) NOT NULL DEFAULT 0,
    "country_id"      integer        NOT NULL REFERENCES "country" ON DELETE RESTRICT,
    "country_zone_id" integer REFERENCES "country_zone" ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS "tax_product"
(
    "tax_product_id" smallserial NOT NULL PRIMARY KEY,
    "name"           varchar(30) NOT NULL DEFAULT ''
);

CREATE TABLE IF NOT EXISTS "tax_client"
(
    "tax_client_id" smallserial NOT NULL PRIMARY KEY,
    "name"          varchar(30) NOT NULL DEFAULT ''
);

CREATE TABLE IF NOT EXISTS "tax_rule"
(
    "tax_rule_id"         smallserial  NOT NULL PRIMARY KEY,
    "name"                varchar(100) NOT NULL,
    "tax_client"          jsonb        NOT NULL,
    "tax_product"         jsonb        NOT NULL,
    "tax_rate"            jsonb        NOT NULL,
    "use_origin_location" bool         NOT NULL DEFAULT FALSE,
    "tax_origin_location" bool         NOT NULL DEFAULT FALSE,
    "priority"            smallint     NOT NULL DEFAULT 0,
    "position"            smallint     NOT NULL DEFAULT 0,
    "active"              bool         NOT NULL DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS "region"
(
    "code"        text PRIMARY KEY,
    "country_id"  int NOT NULL REFERENCES country ON DELETE CASCADE,
    "language_id" smallint,
    "name"        text
);

CREATE TABLE IF NOT EXISTS "place"
(
    "place_id"    serial PRIMARY KEY,
    "name"        text,
    "region_code" text, --should reference region table
    "rhif_id"     text, --should reference rhif table
    "is_city"     bool NOT NULL DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS "address"
(
    "address_id"          serial PRIMARY KEY,
    "country_id"          int NOT NULL, -- reference country
    "place_id"            int,          -- reference place
    "street"              text,
    "residential_complex" text,
    "number"              text,
    "bloc"                text,
    "entrance"            text,
    "floor"               text,
    "apartment"           text,
    "zip"                 varchar(10),
    "region_id"           text,         -- reference region
    "state"               text,
    "address"             text,
    "city"                text,
    "rhif_id"             text
);

CREATE TABLE IF NOT EXISTS "rhif"
(
    "rhif_id"     text PRIMARY KEY,
    "region_code" text NOT NULL REFERENCES "region" (code) ON DELETE CASCADE,
    "code"        text,
    "name"        text
);