#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

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
