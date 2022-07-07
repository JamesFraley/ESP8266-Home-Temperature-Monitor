CREATE TABLE IF NOT EXISTS airqual.airqual
(
    datetime timestamp without time zone NOT NULL DEFAULT now(),
    last_digit character(1) COLLATE pg_catalog."default" NOT NULL,
    ip character varying(20) COLLATE pg_catalog."default" NOT NULL,
    room character varying(30) COLLATE pg_catalog."default",
    tempf real,
    tempc real,
    humidity real,
    event character varying(200) COLLATE pg_catalog."default",
    CONSTRAINT airqual_pkey PRIMARY KEY (datetime, last_digit)
) PARTITION BY LIST (last_digit)

TABLESPACE airqual;

ALTER TABLE IF EXISTS airqual.airqual
    OWNER to postgres;

REVOKE ALL ON TABLE airqual.airqual FROM postgrest;

GRANT ALL ON TABLE airqual.airqual TO postgres;

GRANT INSERT, SELECT ON TABLE airqual.airqual TO postgrest;

-- Partitions SQL

CREATE TABLE airqual.airqual_0 PARTITION OF airqual.airqual
    FOR VALUES IN ('0');

ALTER TABLE IF EXISTS airqual.airqual_0
    OWNER to postgres;
-- Index: airqual_0_datetime

-- DROP INDEX IF EXISTS airqual.airqual_0_datetime;

CREATE INDEX airqual_0_datetime
    ON airqual.airqual_0 USING btree
    (datetime ASC NULLS LAST)
    TABLESPACE airqual;
CREATE TABLE airqual.airqual_1 PARTITION OF airqual.airqual
    FOR VALUES IN ('1');

ALTER TABLE IF EXISTS airqual.airqual_1
    OWNER to postgres;
-- Index: airqual_1_datetime

-- DROP INDEX IF EXISTS airqual.airqual_1_datetime;

CREATE INDEX airqual_1_datetime
    ON airqual.airqual_1 USING btree
    (datetime ASC NULLS LAST)
    TABLESPACE airqual;
CREATE TABLE airqual.airqual_2 PARTITION OF airqual.airqual
    FOR VALUES IN ('2');

ALTER TABLE IF EXISTS airqual.airqual_2
    OWNER to postgres;
-- Index: airqual_2_datetime

-- DROP INDEX IF EXISTS airqual.airqual_2_datetime;

CREATE INDEX airqual_2_datetime
    ON airqual.airqual_2 USING btree
    (datetime ASC NULLS LAST)
    TABLESPACE airqual;
CREATE TABLE airqual.airqual_3 PARTITION OF airqual.airqual
    FOR VALUES IN ('3');

ALTER TABLE IF EXISTS airqual.airqual_3
    OWNER to postgres;
-- Index: airqual_3_datetime

-- DROP INDEX IF EXISTS airqual.airqual_3_datetime;

CREATE INDEX airqual_3_datetime
    ON airqual.airqual_3 USING btree
    (datetime ASC NULLS LAST)
    TABLESPACE airqual;
CREATE TABLE airqual.airqual_4 PARTITION OF airqual.airqual
    FOR VALUES IN ('4');

ALTER TABLE IF EXISTS airqual.airqual_4
    OWNER to postgres;
-- Index: airqual_4_datetime

-- DROP INDEX IF EXISTS airqual.airqual_4_datetime;

CREATE INDEX airqual_4_datetime
    ON airqual.airqual_4 USING btree
    (datetime ASC NULLS LAST)
    TABLESPACE airqual;
CREATE TABLE airqual.airqual_5 PARTITION OF airqual.airqual
    FOR VALUES IN ('5');

ALTER TABLE IF EXISTS airqual.airqual_5
    OWNER to postgres;
-- Index: airqual_5_datetime

-- DROP INDEX IF EXISTS airqual.airqual_5_datetime;

CREATE INDEX airqual_5_datetime
    ON airqual.airqual_5 USING btree
    (datetime ASC NULLS LAST)
    TABLESPACE airqual;
CREATE TABLE airqual.airqual_6 PARTITION OF airqual.airqual
    FOR VALUES IN ('6');

ALTER TABLE IF EXISTS airqual.airqual_6
    OWNER to postgres;
-- Index: airqual_6_datetime

-- DROP INDEX IF EXISTS airqual.airqual_6_datetime;

CREATE INDEX airqual_6_datetime
    ON airqual.airqual_6 USING btree
    (datetime ASC NULLS LAST)
    TABLESPACE airqual;
CREATE TABLE airqual.airqual_7 PARTITION OF airqual.airqual
    FOR VALUES IN ('7');

ALTER TABLE IF EXISTS airqual.airqual_7
    OWNER to postgres;
-- Index: airqual_7_datetime

-- DROP INDEX IF EXISTS airqual.airqual_7_datetime;

CREATE INDEX airqual_7_datetime
    ON airqual.airqual_7 USING btree
    (datetime ASC NULLS LAST)
    TABLESPACE airqual;
CREATE TABLE airqual.airqual_8 PARTITION OF airqual.airqual
    FOR VALUES IN ('8');

ALTER TABLE IF EXISTS airqual.airqual_8
    OWNER to postgres;
-- Index: airqual_8_datetime

-- DROP INDEX IF EXISTS airqual.airqual_8_datetime;

CREATE INDEX airqual_8_datetime
    ON airqual.airqual_8 USING btree
    (datetime ASC NULLS LAST)
    TABLESPACE airqual;
CREATE TABLE airqual.airqual_9 PARTITION OF airqual.airqual
    FOR VALUES IN ('9');

ALTER TABLE IF EXISTS airqual.airqual_9
    OWNER to postgres;
-- Index: airqual_9_datetime

-- DROP INDEX IF EXISTS airqual.airqual_9_datetime;

CREATE INDEX airqual_9_datetime
    ON airqual.airqual_9 USING btree
    (datetime ASC NULLS LAST)
    TABLESPACE airqual;
