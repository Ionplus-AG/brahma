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
create procedure set_run_enabled($run_id int, $enabled bool)
begin
    declare $edit_allowed bool;

    select target.edit_allowed
    into $edit_allowed
    from run
        inner join target on run.target_id = target.id
    where run.id = $run_id;

    if $edit_allowed then
        update run set enabled = $enabled where run.id = $run_id;
        call update_run($run_id);
    end if;
end;

//
delimiter ;
