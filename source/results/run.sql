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

    disabled bool not null default false,
    comment text default null,

    enabled_cycles int default 0,
    total_cycles int default 0,

    runtime double default 0,
    end_of_last_cycle datetime(3) default null,

    r int default null,
    r_delta double default null,

    g1 int default null,
    g1_delta double default null,

    g2 int default null,
    g2_delta double default null,

    ana double default null,
    a double default null,
    b double default null,
    c double default null,

    ratio_r_a double default null,
    ratio_r_a_sigma double default null,
    ratio_r_a_delta double default null,

    ratio_r_b double default null,
    ratio_r_b_sigma double default null,
    ratio_r_b_delta double default null,

    ratio_g1_a double default null,
    ratio_g1_b double default null,
    ratio_g2_a double default null,
    ratio_g2_b double default null,

    ratio_b_a double default null,
    ratio_b_a_sigma double default null,
    ratio_b_a_delta double default null,

    ratio_a_ana double default null,
    ratio_a_ana_sigma double default null,

    constraint run_target_foreign_key
    foreign key (target_id) references target(id),

    constraint run_target_number_unique
    unique (target_id, number),

    constraint run_machine_foreign_key
    foreign key (machine_number) references machine(number)
) engine=innodb;
