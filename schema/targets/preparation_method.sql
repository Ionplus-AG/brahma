#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

create table preparation_method (
    name varchar(20) primary key,
    description text,
    sort_order int not null
) engine=innodb;
