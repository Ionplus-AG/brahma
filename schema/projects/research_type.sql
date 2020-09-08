#
# copyright (c) Ionplus AG and contributors. all rights reserved.
# licensed under the mit license. see license file in the project root for details.
#

create table research_type (
    name varchar(20) primary key,
    sort_order int not null
) engine=innodb;

insert into research_type
values ('undefined', 0),
       ('materials', 10),
       ('archeology', 20),
       ('climate', 30),
       ('water', 40),
       ('air', 50),
       ('soil', 60),
       ('plants', 70),
       ('art', 80),
       ('geochronology', 90),
       ('bomb peak', 100),
       ('geology', 110),
       ('ocean', 120),
       ('biogeochemistry', 130),
       ('environment', 140),
       ('physics', 150),
       ('reference material', 160);
