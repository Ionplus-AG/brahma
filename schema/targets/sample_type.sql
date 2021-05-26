#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

create table sample_type (
    name varchar(20) primary key,
    sort_order int not null,
    f14c double,
    f14c_sigma double,
    d13c double,
    d13c_sigma double,
    d13c_nominal double default -25,
    blank smallint(6) not null default 0,
    active smallint(6) not null default 0
) engine=innodb;
