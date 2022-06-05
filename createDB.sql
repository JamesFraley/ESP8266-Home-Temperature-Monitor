drop table if exists airqual.airqual;

CREATE TABLE IF NOT EXISTS airqual.airqual
(
    datetime timestamp without time zone NOT NULL DEFAULT now(),
    last_digit character(1)  NOT NULL,
    ip varchar(20) NOT NULL,
    tempf real,
    tempc real,
    humidity real,
    CONSTRAINT airqual_pkey PRIMARY KEY (datetime, last_digit)
) PARTITION BY LIST(last_digit)
TABLESPACE airqual;

CREATE TABLE airqual.airqual_0 PARTITION OF airqual.airqual FOR VALUES IN ('0');
CREATE TABLE airqual.airqual_1 PARTITION OF airqual.airqual FOR VALUES IN ('1');
CREATE TABLE airqual.airqual_2 PARTITION OF airqual.airqual FOR VALUES IN ('2');
CREATE TABLE airqual.airqual_3 PARTITION OF airqual.airqual FOR VALUES IN ('3');
CREATE TABLE airqual.airqual_4 PARTITION OF airqual.airqual FOR VALUES IN ('4');
CREATE TABLE airqual.airqual_5 PARTITION OF airqual.airqual FOR VALUES IN ('5');
CREATE TABLE airqual.airqual_6 PARTITION OF airqual.airqual FOR VALUES IN ('6');
CREATE TABLE airqual.airqual_7 PARTITION OF airqual.airqual FOR VALUES IN ('7');
CREATE TABLE airqual.airqual_8 PARTITION OF airqual.airqual FOR VALUES IN ('8');
CREATE TABLE airqual.airqual_9 PARTITION OF airqual.airqual FOR VALUES IN ('9');

create index airqual_0_datetime on airqual.airqual_0(datetime) tablespace airqual;
create index airqual_1_datetime on airqual.airqual_1(datetime) tablespace airqual;
create index airqual_2_datetime on airqual.airqual_2(datetime) tablespace airqual;
create index airqual_3_datetime on airqual.airqual_3(datetime) tablespace airqual;
create index airqual_4_datetime on airqual.airqual_4(datetime) tablespace airqual;
create index airqual_5_datetime on airqual.airqual_5(datetime) tablespace airqual;
create index airqual_6_datetime on airqual.airqual_6(datetime) tablespace airqual;
create index airqual_7_datetime on airqual.airqual_7(datetime) tablespace airqual;
create index airqual_8_datetime on airqual.airqual_8(datetime) tablespace airqual;
create index airqual_9_datetime on airqual.airqual_9(datetime) tablespace airqual;

CREATE ROLE postgrest WITH
  LOGIN
  INHERIT
  PASSWORD 'postgrest';

grant insert,select on airqual.airqual to postgrest;

GRANT USAGE ON SCHEMA airqual TO postgrest;


