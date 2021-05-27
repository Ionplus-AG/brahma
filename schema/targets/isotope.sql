#
# copyright (c) Ionplus AG and contributors. all rights reserved.
# licensed under the mit license. see license file in the project root for details.
#

create table isotope (
    number int primary key auto_increment,
    name varchar(20) unique not null,
    name_markup varchar(30) not null
) engine=innodb;

insert into isotope
values (1, 'Al26', '^{26}Al'),
       (2, 'Be10', '^{10}Be'),
       (3, 'C14', '^{14}C'),
       (4, 'Ca41', '^{41}Ca'),
       (5, 'I129', '^{129}I'),
       (6, 'Pu', 'Pu'),
       (7, 'Si32', '^{32}Si'),
       (8, 'U', 'U');

