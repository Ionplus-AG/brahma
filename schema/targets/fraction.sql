#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

create table fraction (
    name varchar(20) primary key,
    sort_order int not null
) engine=innodb;
