#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

create table config_variable (
    name varchar(20) not null,
    machine_number int not null,

    i_value int default null,
    f_value double default null,
    c_value tinytext default null,

    readonly bool not null default false,

    primary key (name, machine_number),

    constraint config_variable_machine_foreign_key
    foreign key (machine_number) references machine(number)
) engine=innodb;
