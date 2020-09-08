#
# Copyright (c) Ionplus AG and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

delimiter //

# summary:
# Enables/disables the specified cycle and re-calculates the associated run/target.
#
# params:
# - $cycle_id: The identifier of the cycle.
# - $enabled: If set the true, the cycle will be enabled. Otherwise the cycle will be disabled.
create procedure set_cycle_enabled($cycle_id int, $enabled bool)
begin
    declare $run_id int;
    declare $target_id int;
    declare $edit_allowed bool;

    select cycle.run_id, target.id, target.edit_allowed
    into $run_id, $target_id, $edit_allowed
    from cycle
        inner join run on cycle.run_id = run.id
        inner join target on run.target_id = target.id
    where cycle.id = $cycle_id;

    if $edit_allowed then
        update cycle set enabled = $enabled where cycle.id = $cycle_id;
        call calculate_run($run_id);
        call calculate_target($target_id);
    end if;
end;

//
delimiter ;
