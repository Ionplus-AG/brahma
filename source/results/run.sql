#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

create table run (
    id int primary key auto_increment,

    target_id int not null,
    number int not null,

    machine_number int not null,

    spectrum_path tinytext default null,

    constraint run_target_foreign_key
    foreign key (target_id) references target(id),

    constraint run_target_number_unique
    unique (target_id, number),

    constraint run_machine_foreign_key
    foreign key (machine_number) references machine(number)
) engine=innodb;
