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


delimiter //

create function count_by_current(count int, current double, runtime_micros double, electrical_charge double)
returns double deterministic
begin
    declare elementary_charge double default 1.60217662e-19;
    declare result double default null;

    if count >= 0 && current > 0 && runtime_micros > 0 && electrical_charge <> 0
    then
        set result = (count * 1e6 * electrical_charge * elementary_charge) / (current * runtime_micros);
    end if;

    return result;
end;

create function current_by_current(first double, second double)
returns double deterministic
begin
    declare result double default null;

    if first >= 0 && second > 0
    then
        set result = first / second;
    end if;

    return result;
end;

create trigger cycle_calculate_ratios_on_insert
before insert on cycle for each row
begin
    declare charge double default null;

    select electrical_charge into charge
    from cycle_definition where cycle_definition.id = new.cycle_definition_id;

    set new.ratio_r_a = count_by_current(new.r, new.a, new.runtime_micros, charge);
    set new.ratio_r_b = count_by_current(new.r, new.b, new.runtime_micros, charge);
    set new.ratio_g1_a = count_by_current(new.g1, new.a, new.runtime_micros, charge);
    set new.ratio_g1_b = count_by_current(new.g1, new.b, new.runtime_micros, charge);
    set new.ratio_g2_a = count_by_current(new.g2, new.a, new.runtime_micros, charge);
    set new.ratio_g2_b = count_by_current(new.g2, new.b, new.runtime_micros, charge);
    set new.ratio_b_a = current_by_current(new.b, new.a);
    set new.ratio_a_ana = current_by_current(new.a, new.ana * charge);
end;

create trigger cycle_calculate_ratios_on_update
before update on cycle for each row
begin
    declare charge double default null;

    select electrical_charge into charge
    from cycle_definition where cycle_definition.id = new.cycle_definition_id;

    set new.ratio_r_a = count_by_current(new.r, new.a, new.runtime_micros, charge);
    set new.ratio_r_b = count_by_current(new.r, new.b, new.runtime_micros, charge);
    set new.ratio_g1_a = count_by_current(new.g1, new.a, new.runtime_micros, charge);
    set new.ratio_g1_b = count_by_current(new.g1, new.b, new.runtime_micros, charge);
    set new.ratio_g2_a = count_by_current(new.g2, new.a, new.runtime_micros, charge);
    set new.ratio_g2_b = count_by_current(new.g2, new.b, new.runtime_micros, charge);
    set new.ratio_b_a = current_by_current(new.b, new.a);
    set new.ratio_a_ana = current_by_current(new.a, new.ana * charge);
end;

//
delimiter ;
