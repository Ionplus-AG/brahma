#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

delimiter //

# summary:
# Triggers calculating the ratios on the inserted or updated cycles.
create trigger calculate_cycle_ratios_on_insert
before insert on cycle for each row
begin
    declare $charge double default null;

    select electrical_charge into $charge
    from cycle_definition where cycle_definition.id = new.cycle_definition_id;

    set new.ratio_r_a = count_by_current_ratio(new.r, new.a, new.runtime, $charge);
    set new.ratio_r_b = count_by_current_ratio(new.r, new.b, new.runtime, $charge);
    set new.ratio_g1_a = count_by_current_ratio(new.g1, new.a, new.runtime, $charge);
    set new.ratio_g1_b = count_by_current_ratio(new.g1, new.b, new.runtime, $charge);
    set new.ratio_g2_a = count_by_current_ratio(new.g2, new.a, new.runtime, $charge);
    set new.ratio_g2_b = count_by_current_ratio(new.g2, new.b, new.runtime, $charge);
    set new.ratio_b_a = safe_ratio(new.b, new.a);
    set new.ratio_a_ana = safe_ratio(new.a, new.ana * $charge);
end;

create trigger calculate_cycle_ratios_on_update
before update on cycle for each row
begin
    declare $charge double default null;

    select electrical_charge into $charge
    from cycle_definition where cycle_definition.id = new.cycle_definition_id;

    set new.ratio_r_a = count_by_current_ratio(new.r, new.a, new.runtime, $charge);
    set new.ratio_r_b = count_by_current_ratio(new.r, new.b, new.runtime, $charge);
    set new.ratio_g1_a = count_by_current_ratio(new.g1, new.a, new.runtime, $charge);
    set new.ratio_g1_b = count_by_current_ratio(new.g1, new.b, new.runtime, $charge);
    set new.ratio_g2_a = count_by_current_ratio(new.g2, new.a, new.runtime, $charge);
    set new.ratio_g2_b = count_by_current_ratio(new.g2, new.b, new.runtime, $charge);
    set new.ratio_b_a = safe_ratio(new.b, new.a);
    set new.ratio_a_ana = safe_ratio(new.a, new.ana * $charge);
end;

//
delimiter ;
