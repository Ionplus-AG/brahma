#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

create table magazine (
    id int primary key auto_increment,
    name varchar(12) not null,
    is_gas bool not null default false,
    last_changed timestamp not null default current_timestamp on update current_timestamp,

    unique magazine_name_unique (name),
    index magazine_last_changed_index (last_changed)
) engine=innodb;
