#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

create table preparation_method (
    name varchar(20) primary key,
    description text,
    sort_order int not null
) engine=innodb;

insert into preparation_method
values ('undefined', null, 0),
       ('Acid 60°', null, 1),
       ('ABA 60°', null, 2),
       ('fumigation', null, 4),
       ('combustion', null, 6),
       ('gc', null, 8),
       ('ABA 20°', null, 10),
       ('ABOX', null, 20),
       ('acidification', null, 24),
       ('alphacellulose', null, 30),
       ('cellulose BABAB', null, 40),
       ('cellulose BBB', null, 42),
       ('collagene', null, 50),
       ('cremated bones wash', null, 51),
       ('column', null, 60),
       ('Cu oxid', null, 80),
       ('drying 60C', null, 82),
       ('filtration', null, 84),
       ('freeze drying', null, 90),
       ('heavy liquid', null, 100),
       ('hemicellulose', null, 110),
       ('hplc', null, 120),
       ('hypy', null, 128),
       ('insitu quartz', null, 130),
       ('leaching', null, 140),
       ('longin+base', null, 150),
       ('microwave extraction', null, 160),
       ('multivap', null, 165),
       ('NaOH absorption', null, 167),
       ('pollen', null, 170),
       ('pyrolysis', null, 175),
       ('ramped pyrolysis', null, 178),
       ('sieving', null, 180),
       ('soxhlet', null, 190),
       ('step comb', null, 200),
       ('SrCl2 precipitation', null, 206),
       ('ultra sonic', null, 210),
       ('ultrafiltration', null, 220),
       ('WCO', null, 230);


