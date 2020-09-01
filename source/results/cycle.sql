#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

create table cycle (
    id int primary key auto_increment,

    run_id int not null,
    number int not null,
    cycle_definition_id int not null,

    runtime double not null,
    end_of_cycle datetime(3) not null,

    disabled bool not null default false,

    r int default null,
    g1 int default null,
    g2 int default null,

    ana double default null,
    a double default null,
    b double default null,
    c double default null,

    ratio_r_a double default null,
    ratio_r_b double default null,
    ratio_g1_a double default null,
    ratio_g1_b double default null,
    ratio_g2_a double default null,
    ratio_g2_b double default null,
    ratio_b_a double default null,
    ratio_a_ana double default null,

    constraint cycle_run_foreign_key
    foreign key (run_id) references run(id),

    constraint cycle_definition_foreign_key
    foreign key (cycle_definition_id) references cycle_definition(id),

    constraint cycle_run_number_definition_unique
    unique (run_id, number, cycle_definition_id)
) engine=innodb;