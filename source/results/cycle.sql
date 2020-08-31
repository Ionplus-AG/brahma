#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

create table cycle (
    id int primary key auto_increment,

    run_id int not null,
    number int not null,
    cycle_definition_id int not null,

    runtime_micros double not null,
    end_of_cycle datetime(6) not null,

    r int default null,
    g1 int default null,
    g2 int default null,

    ana double default null,
    a double default null,
    b double default null,
    c double default null,

    disabled bool not null default false,

    constraint cycle_run_foreign_key
    foreign key (run_id) references run(id),

    constraint cycle_definition_foreign_key
    foreign key (cycle_definition_id) references cycle_definition(id),

    constraint cycle_run_number_definition_unique
    unique (run_id, number, cycle_definition_id)
) engine=innodb;

create view cycle_ratios as
    select
           cycle.id as cycle_id,

           if((r >= 0) && (a > 0) && (runtime_micros >= 0) && (electrical_charge <> 0),
               r/(a/1e6/electrical_charge/elementary_charge*runtime_micros),
               null) as r_a,

           if((r >= 0) && (b > 0) && (runtime_micros >= 0) && (electrical_charge <> 0),
               r/(b/1e6/electrical_charge/elementary_charge*runtime_micros),
               null) as r_b,

           if((g1 >= 0) && (a > 0) && (runtime_micros >= 0) && (electrical_charge <> 0),
               g1/(a/1e6/electrical_charge/elementary_charge*runtime_micros),
               null) as g1_a,

           if((g1 >= 0) && (b > 0) && (runtime_micros >= 0) && (electrical_charge <> 0),
               g1/(b/1e6/electrical_charge/elementary_charge*runtime_micros),
               null) as g1_b,

           if((g2 >= 0) && (a > 0) && (runtime_micros >= 0) && (electrical_charge <> 0),
               g2/(a/1e6/electrical_charge/elementary_charge*runtime_micros),
               null) as g2_a,

           if((g2 >= 0) && (b > 0) && (runtime_micros >= 0) && (electrical_charge <> 0),
               g2/(b/1e6/electrical_charge/elementary_charge*runtime_micros),
               null) as g2_b,

           if((a > 0) && (b >= 0),
               b/a,
               null) as b_a,

           if((ana > 0) && (a >= 0) && (electrical_charge <> 0),
               a/ana/electrical_charge,
               null) as a_ana

    from cycle
        inner join cycle_definition cd on cycle.cycle_definition_id = cd.id
        inner join (select (1.60217662E-19) as elementary_charge) const;
