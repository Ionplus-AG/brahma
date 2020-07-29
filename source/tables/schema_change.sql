create table schema_change (
    version int primary key,
    date_applied datetime not null
) engine=innodb;
