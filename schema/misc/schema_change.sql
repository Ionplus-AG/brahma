#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

create table schema_change (
    version int primary key,
    date_applied datetime not null
) engine=innodb;
