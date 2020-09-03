#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

create table machine (
    number int primary key auto_increment,

    name varchar(50) not null,
    prefix varchar(10) not null,

    constraint machine_name_unique
    unique (name),

    constraint machine_prefix_unique
    unique (prefix)
) engine=innodb;
