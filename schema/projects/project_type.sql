#
# copyright (c) Ionplus AG and contributors. all rights reserved.
# licensed under the mit license. see license file in the project root for details.
#

create table project_type (
    name varchar(20) primary key,
    sort_order int not null
) engine=innodb;

insert into project_type
values ('undefined', 0),
       ('research contracts', 10),
       ('eu', 20),
       ('internal', 30),
       ('commercial', 40);
