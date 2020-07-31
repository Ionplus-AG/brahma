
source dummy.sql;
source tables/schema_change.sql;

insert into schema_change (version, date_applied) values (1, NOW());
