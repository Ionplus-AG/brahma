#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

create table cycle_definition (
    id int primary key auto_increment,
    creation_date timestamp not null default current_timestamp on update current_timestamp,

    isotope_number int not null,
    machine_number int not null,
    sequence int not null default 0, # TODO, ewc 2020-08-26: we decided on 'index' previously, but that's a reserved keyword in SQL

    electrical_charge double not null default 1.0,

    name tinytext default null,

    r_name tinytext default null,
    g1_name tinytext default null,
    g2_name tinytext default null,

    ana_name tinytext default null,
    a_name tinytext default null,
    b_name tinytext default null,
    c_name tinytext default null,

    constraint cycle_definition_isotope_foreign_key
    foreign key (isotope_number) references isotope(number),

    constraint cycle_definition_machine_foreign_key
    foreign key (machine_number) references machine(number)
) engine=innodb;
